import os
import optuna
import numpy as np

import torch
import torch.nn as nn
from torch.utils.data import DataLoader, random_split
from torchvision import datasets, transforms

import snntorch as snn
from snntorch import spikegen

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print("Using device:", device)

#
# ── 1. DEFINE YOUR SNNTorch NETWORK ───────────────────────────────────────────
#
class Net(nn.Module):
    def __init__(self, num_inputs, num_hidden, num_outputs, beta):
        super().__init__()
        self.fc1 = nn.Linear(num_inputs, num_hidden, bias=False)
        self.lif1 = snn.Leaky(beta=beta)
        self.fc2 = nn.Linear(num_hidden, num_outputs, bias=False)
        self.lif2 = snn.Leaky(beta=beta)

    def forward(self, data, num_steps, gain=1):
        """
        - data: single minibatch of shape (batch_size, num_inputs)
        - num_steps: timesteps to simulate
        - gain: parameter passed into spikegen.rate
        """
        # initialize membrane potentials
        mem1 = self.lif1.init_leaky()  # shape: (batch_size, num_hidden)
        mem2 = self.lif2.init_leaky()  # shape: (batch_size, num_outputs)

        spk2_rec = []
        mem2_rec = []

        # generate poisson‐spike trains from the real-valued inputs
        input_spikes = spikegen.rate(data, num_steps=num_steps, gain=gain)

        for step in range(num_steps):
            cur1 = self.fc1(input_spikes[step])
            spk1, mem1 = self.lif1(cur1, mem1)
            cur2 = self.fc2(spk1)
            spk2, mem2 = self.lif2(cur2, mem2)
            spk2_rec.append(spk2)
            mem2_rec.append(mem2)

        # stack along time dimension → shape: (num_steps, batch_size, num_outputs)
        return torch.stack(spk2_rec), torch.stack(mem2_rec)

#
# ── 2. DEFINE TRAIN / EVAL HELPERS ─────────────────────────────────────────────
#
def train_one_epoch(net, dataloader, optimizer, loss_fn, num_steps, gain=1):
    net.train()
    running_loss = 0.0
    total_batches = 0

    for data, labels in dataloader:
        data = data.view(data.size(0), -1).to(device)     # (batch_size, 784)
        labels = labels.to(device)

        optimizer.zero_grad()
        spk_rec, mem_rec = net(data, num_steps=num_steps, gain=gain)

        # aggregate loss over timesteps (using membrane potentials)
        loss_val = torch.zeros(1, device=device)
        for t in range(num_steps):
            loss_val += loss_fn(mem_rec[t], labels)

        loss_val.backward()
        optimizer.step()

        running_loss += loss_val.item()
        total_batches += 1

    return running_loss / total_batches


def evaluate(net, dataloader, loss_fn, num_steps, gain=1):
    net.eval()
    total_loss = 0.0
    total_correct = 0
    total_examples = 0

    with torch.no_grad():
        for data, labels in dataloader:
            bs = data.size(0)
            data = data.view(bs, -1).to(device)
            labels = labels.to(device)

            spk_rec, mem_rec = net(data, num_steps=num_steps, gain=gain)

            # compute loss‐over‐time
            loss_val = torch.zeros(1, device=device)
            for t in range(num_steps):
                loss_val += loss_fn(mem_rec[t], labels)
            total_loss += loss_val.item()

            # compute spike‐count‐based output
            # sum spikes over time → shape (batch_size, num_outputs)
            out_spk_sum = spk_rec.sum(dim=0)  # (batch_size, num_outputs)
            preds = out_spk_sum.argmax(dim=1)  # (batch_size,)
            total_correct += (preds == labels).sum().item()
            total_examples += bs

    avg_loss = total_loss / len(dataloader)
    accuracy = total_correct / total_examples
    return avg_loss, accuracy


#
# ── 3. SET UP DATA & DATALOADERS ────────────────────────────────────────────────
#
DATA_DIR = "./data/mnist"
BATCH_SIZE = 256

transform = transforms.Compose([
    transforms.Resize((28, 28)),
    transforms.Grayscale(),
    transforms.ToTensor(),
    transforms.Normalize((0.0,), (1.0,))
])

full_trainset = datasets.MNIST(root=DATA_DIR, train=True, download=True, transform=transform)
testset     = datasets.MNIST(root=DATA_DIR, train=False, download=True, transform=transform)

# Split the original training set into "train" + "valid" for hyperparameter search
n_train = int(len(full_trainset) * 0.9)
n_val   = len(full_trainset) - n_train
trainset, valset = random_split(full_trainset, [n_train, n_val])

train_loader = DataLoader(trainset, batch_size=BATCH_SIZE, shuffle=True, drop_last=True)
val_loader   = DataLoader(valset,   batch_size=BATCH_SIZE, shuffle=False, drop_last=True)
test_loader  = DataLoader(testset,  batch_size=BATCH_SIZE, shuffle=False, drop_last=True)

#
# ── 4. DEFINE THE OPTUNA OBJECTIVE ─────────────────────────────────────────────
#
def objective(trial):
    # ─ Sample hyperparameters ─────────────────────────────────────────────────
    # We want to tune: hidden‐layer size, gain, num_steps.
    num_hidden = trial.suggest_int("num_hidden", 50, 250, step=10)
    #gain       = trial.suggest_float("gain", 0.1, 1.0, step=0.05)
    num_steps  = trial.suggest_int("num_steps", 5, 45, step=5)
    beta        = trial.suggest_categorical("beta", [0.0, 0.5, 0.9375])
    # (Optionally, you could also tune learning rate, weight decay, etc.)
    lr = trial.suggest_float("lr", 1e-4, 1.2e-4, log=True)

    # ─ Instantiate model, loss, optimizer ───────────────────────────────────────
    net = Net(
        num_inputs=28*28,
        num_hidden=num_hidden,
        num_outputs=10,
        beta=beta
    ).to(device)

    loss_fn   = nn.CrossEntropyLoss()
    optimizer = torch.optim.Adam(net.parameters(), lr=lr, weight_decay=5e-6)

    # ─ Train for a few epochs (e.g., 5) ──────────────────────────────────────────
    N_EPOCHS = 5
    for epoch in range(N_EPOCHS):
        train_loss = train_one_epoch(net, train_loader, optimizer, loss_fn, num_steps)
        val_loss, val_acc = evaluate(net, val_loader, loss_fn, num_steps)

        # Report intermediate metrics to Optuna for pruning
        trial.report(val_acc, step=epoch)
        if trial.should_prune():
            raise optuna.exceptions.TrialPruned()

    # Return the final validation accuracy (we want to maximize)
    return val_acc

#
# ── 5. RUN THE STUDY ────────────────────────────────────────────────────────────
#
if __name__ == "__main__":
    # Create an Optuna study that maximizes accuracy
    study = optuna.create_study(direction="maximize", sampler=optuna.samplers.TPESampler())
    study.optimize(objective, n_trials=60, timeout=120*60)  # e.g. up to 30 trials or 1 hour

    print("Best trial:")
    trial = study.best_trial
    print(f"  Validation Accuracy: {trial.value:.4f}")
    print("  Params:")
    for key, val in trial.params.items():
        print(f"    {key}: {val}")

    # ── 6. (OPTIONAL) Retrain on train+val with best hyperparameters ────────────
    best_num_hidden = trial.params["num_hidden"]
    #best_gain       = trial.params["gain"]
    best_num_steps  = trial.params["num_steps"]
    best_lr         = trial.params["lr"]
    best_beta       = trial.params["beta"]

    # Re‐create full training loader (train+val) and test loader
    combined_trainset = torch.utils.data.ConcatDataset([trainset, valset])
    combined_loader   = DataLoader(combined_trainset, batch_size=BATCH_SIZE, shuffle=True, drop_last=True)

    # Instantiate final model
    final_net = Net(num_inputs=28*28,
                    num_hidden=best_num_hidden,
                    num_outputs=10,
                    beta=best_beta).to(device)

    final_loss_fn   = nn.CrossEntropyLoss()
    final_optimizer = torch.optim.Adam(final_net.parameters(), lr=best_lr, weight_decay=5e-6)

    N_FINAL_EPOCHS = 20  # you can train longer now
    for epoch in range(N_FINAL_EPOCHS):
        _ = train_one_epoch(final_net, combined_loader, final_optimizer,
                            final_loss_fn, best_num_steps)
        if (epoch + 1) % 5 == 0:
            val_loss, val_acc = evaluate(final_net, val_loader, final_loss_fn,
                                         best_num_steps)
            print(f"[Retrain] Epoch {epoch+1}/{N_FINAL_EPOCHS} → Val Acc: {val_acc*100:.2f}%")

    # Evaluate on the held‐out test set
    test_loss, test_acc = evaluate(final_net, test_loader, final_loss_fn,
                                   best_num_steps)
    print(f"\nFinal Test Accuracy: {test_acc*100:.2f}%")

