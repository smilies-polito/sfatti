import logging
import random
import numpy as np
import torch
from copy import deepcopy

from spikerplus.dataloaders import MnistDL
from spikerplus import NetBuilder, Trainer
from optimizer import Optimizer
import json
from datetime import datetime

##############
# PARAMETERS #
##############
batch_size = 64
n_epochs = 30
data_dir = "Mnist/data"
# Base network configuration, modify it with the desired initial config
base_net_dict = {
    "n_cycles": 10,
    "n_inputs": 784,
    "layer_0": {
        "neuron_model": "lif",
        "n_neurons": 50,
        "beta": 0.9375,
        "learn_beta": False,
        "threshold": 1.0,
        "learn_threshold": False,
        "reset_mechanism": "subtract"
    },
    "layer_1": {
        "neuron_model": "lif",
        "n_neurons": 10,
        "beta": 0.9375,
        "learn_beta": False,
        "threshold": 1.0,
        "learn_threshold": False,
        "reset_mechanism": "none"
    }
}
# Quantization‐search configuration
optim_config = {
    "weights_bw": {"min": 4, "max": 10},
    "neurons_bw": {"min": 4, "max": 10},
    "fp_dec":     {"min": 4, "max": 6}
}

logging.basicConfig(level=logging.INFO)
# Ensure deterministic behavior in PyTorch
torch.backends.cudnn.deterministic = True
torch.backends.cudnn.benchmark = False

#####################
# EXPLORATION SWEEP #
#####################
final_results = []
best_overall = {"seed": None, "accuracy": -float("inf"), "config": None}
# Sweep seeds
for seed in range(80, 90):
    # Set random seeds for reproducibility
    random.seed(seed)
    np.random.seed(seed)
    torch.manual_seed(seed)
    torch.cuda.manual_seed_all(seed)
    # Deep copy the base network dict to avoid modifying it
    net_dict = deepcopy(base_net_dict)
    # Build data loaders (using num_steps = n_cycles)
    data_loader = MnistDL(data_dir=data_dir, num_steps=base_net_dict["n_cycles"])
    train_loader, test_loader = data_loader.load(batch_size=batch_size)
    # Build and train the SNN
    net_builder = NetBuilder(net_dict)
    snn = net_builder.build()
    trainer = Trainer(snn)
    trainer.train(train_loader, test_loader, n_epochs=n_epochs, store=False)
    # Quantization sweep via Optimizer.optimize()
    opt = Optimizer(snn, net_dict, optim_config)
    all_quant_results = opt.optimize(test_loader)
    print(all_quant_results)
    # Filter only those quant tuples with accuracy ≥ 97.5%
    passing = [r for r in all_quant_results if r["accuracy"] >= 97.5]
    # If any quantization passes, record them under this neuron count
    if passing:
        final_results.append({
            "seed": seed,
            "results": passing
        })
        # Update best overall
        best_for_seed = max(passing, key=lambda x: x["accuracy"])
        if best_for_seed["accuracy"] > best_overall["accuracy"]:
            best_overall["seed"] = seed
            best_overall["accuracy"] = best_for_seed["accuracy"]
            best_overall["config"] = best_for_seed

###############
# LOG RESULTS #
###############
# Define filename with timestamp
timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
log_filename = f"seed_results_{timestamp}.log"

with open(log_filename, "w") as log_file:
    log_file.write("SPARX QUANTIZATION RESULTS\n")
    log_file.write("=" * 80 + "\n\n")
    # No configuration passed
    if not final_results:
        log_file.write("No configurations achieved the target accuracy of 97.5%\n")
    # Print passing configurations
    else:
        log_file.write(f"Found {len(final_results)} seeds with configurations ≥ 97.5% accuracy\n\n")
        for entry in final_results:
            seed = entry["seed"]
            results = entry["results"]
            log_file.write(f"SEED: {seed}\n")
            log_file.write("-" * 60 + "\n")
            log_file.write(f"{'FP_DEC':<8}{'WEIGHTS_BW':<12}{'NEURONS_BW':<12}{'LOSS':<10}{'ACCURACY':<10}\n")
            # Sort by the quantized configurations by accuracy
            for r in sorted(results, key=lambda x: x["accuracy"], reverse=True):
                log_file.write(f"{r['fp_dec']:<8}{r['weights_bw']:<12}{r['neurons_bw']:<12}{r['loss']:<10.4f}{r['accuracy']:<10.2f}\n")
            log_file.write("\n")

    # Print the result with the best accuracy
    if best_overall["seed"] is not None:
        cfg = best_overall["config"]
        log_file.write("BEST OVERALL\n")
        log_file.write("-" * 60 + "\n")
        log_file.write(f"Seed: {best_overall['seed']}\n")
        log_file.write(f"Configuration: FP_DEC={cfg['fp_dec']}, WEIGHTS_BW={cfg['weights_bw']}, "
                       f"NEURONS_BW={cfg['neurons_bw']}\n")
        log_file.write(f"Accuracy: {best_overall['accuracy']:.2f}%\n")

print(f"Results written to {log_filename}")
if best_overall["seed"] is not None:
    print(f"Best overall configuration: Seed {best_overall['seed']}, "
          f"Accuracy {best_overall['accuracy']:.2f}%, "
          f"Config: FP_DEC={cfg['fp_dec']}, WEIGHTS_BW={cfg['weights_bw']}, NEURONS_BW={cfg['neurons_bw']}")
else:
    print("No configurations achieved the target accuracy of 97.5% across all seeds.")

