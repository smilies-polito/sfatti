import logging
import random
import numpy as np
import torch
from copy import deepcopy
from spikerplus.dataloaders import MnistDL
from spikerplus import NetBuilder, Trainer
from optimizer import Optimizer
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
        "neuron_model": "lif",  # Will be overridden during exploration
        "n_neurons": 50,
        "beta": 0.9375,
        "learn_beta": False,
        "threshold": 1.0,
        "learn_threshold": False,
        "reset_mechanism": "subtract"  # Will be overridden during exploration
    },
    "layer_1": {
        "neuron_model": "rsyn",
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

# Neuron types to explore
neuron_types = ["lif", "rlif", "syn", "rsyn"]
# Reset mechanisms to explore for layer 0
reset_mechanisms = ["subtract", "zero"]

logging.basicConfig(level=logging.INFO)
# Ensure deterministic behavior in PyTorch
seed = 85
torch.backends.cudnn.deterministic = True
torch.backends.cudnn.benchmark = False
random.seed(seed)
np.random.seed(seed)
torch.manual_seed(seed)
torch.cuda.manual_seed_all(seed)

#####################
# EXPLORATION SWEEP #
#####################
final_results = []
best_overall = {
    "neuron_type": None, 
    "reset_mechanism": None, 
    "accuracy": -float("inf"), 
    "config": None
}

# Sweep neuron types and reset mechanisms
for neuron_type in neuron_types:
    for reset_mechanism in reset_mechanisms:
        # Deep‐copy the base net_dict and override neuron type and reset mechanism
        net_dict = deepcopy(base_net_dict)
        net_dict["layer_0"]["neuron_model"] = neuron_type
        net_dict["layer_0"]["reset_mechanism"] = reset_mechanism
        
        print(f"Testing neuron_type={neuron_type}, reset_mechanism={reset_mechanism}")
        
        # Build data loaders (using num_steps = n_cycles)
        data_loader = MnistDL(data_dir=data_dir, num_steps=net_dict["n_cycles"])
        train_loader, test_loader = data_loader.load(batch_size=batch_size)
        
        # Build and train the floating‐point SNN
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
        
        # If any quantization passes, record them under this configuration
        if passing:
            final_results.append({
                "neuron_type": neuron_type,
                "reset_mechanism": reset_mechanism,
                "results": passing
            })
            
            # Update best overall
            best_for_config = max(passing, key=lambda x: x["accuracy"])
            if best_for_config["accuracy"] > best_overall["accuracy"]:
                best_overall["neuron_type"] = neuron_type
                best_overall["reset_mechanism"] = reset_mechanism
                best_overall["accuracy"] = best_for_config["accuracy"]
                best_overall["config"] = best_for_config

###############
# LOG RESULTS #
###############
# Define filename with timestamp
timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
log_filename = f"ntype_results_{timestamp}.log"

with open(log_filename, "w") as log_file:
    log_file.write("SPARX NEURON TYPE EXPLORATION RESULTS\n")
    log_file.write("=" * 80 + "\n\n")
    # No configuration passed
    if not final_results:
        log_file.write("No configurations achieved the target accuracy of 97.5%\n")
    # Print passing configurations
    else:
        log_file.write(f"Found {len(final_results)} neuron type configurations with accuracies ≥ 97.5%\n\n")
        for entry in final_results:
            neuron_type = entry["neuron_type"]
            reset_mechanism = entry["reset_mechanism"]
            results = entry["results"]
            
            log_file.write(f"NEURON TYPE: {neuron_type}, RESET MECHANISM: {reset_mechanism}\n")
            log_file.write("-" * 80 + "\n")
            log_file.write(f"{'FP_DEC':<8}{'WEIGHTS_BW':<12}{'NEURONS_BW':<12}{'LOSS':<10}{'ACCURACY':<10}\n")
            
            # Sort by the quantized configurations by accuracy
            for r in sorted(results, key=lambda x: x["accuracy"], reverse=True):
                log_file.write(f"{r['fp_dec']:<8}{r['weights_bw']:<12}{r['neurons_bw']:<12}{r['loss']:<10.4f}{r['accuracy']:<10.2f}\n")
            log_file.write("\n")

    # Print the result with the best accuracy
    if best_overall["neuron_type"] is not None and best_overall["config"] is not None:
        cfg = best_overall["config"]
        log_file.write("BEST OVERALL\n")
        log_file.write("-" * 80 + "\n")
        log_file.write(f"Neuron Type: {best_overall['neuron_type']}\n")
        log_file.write(f"Reset Mechanism: {best_overall['reset_mechanism']}\n")
        log_file.write(f"Configuration: FP_DEC={cfg['fp_dec']}, WEIGHTS_BW={cfg['weights_bw']}, "
                      f"NEURONS_BW={cfg['neurons_bw']}\n")
        log_file.write(f"Accuracy: {best_overall['accuracy']:.2f}%\n")

print(f"Results written to {log_filename}")
if best_overall["neuron_type"] is not None:
    print(f"Best neuron type: {best_overall['neuron_type']} | "
          f"Reset mechanism: {best_overall['reset_mechanism']} | "
          f"Accuracy: {best_overall['accuracy']:.2f}% | "
          f"Config: {best_overall['config']}")
else:
    print("No configuration achieved the target accuracy.")