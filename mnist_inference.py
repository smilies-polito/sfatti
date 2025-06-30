import logging

import torch
import numpy as np
import random

from spikerplus.dataloaders import MnistDL
from spikerplus import Optimizer, NetBuilder, VhdlGenerator, Trainer
from spikerplus.vhdl import write_vhdl, compile_vhdl, elaborate_vhdl
from spikerplus.vhdl import NetworkSimulator

from configurations import *

net_config_best = {
    "n_cycles":             10,
    "n_inputs":             784,
    "layer_0": {
        "neuron_model":     "lif",
        "n_neurons":        75,
        "beta":             0.9375,
        "learn_beta":       False,
        "threshold":        1.0,
        "learn_threshold":  False,
        "reset_mechanism":  "subtract"
    },
    "layer_1": {
        "neuron_model":     "lif",
        "n_neurons":        10,
        "beta":             0.9375,
        "learn_beta":       False,
        "threshold":        1.0,
        "learn_threshold":  False,
        "reset_mechanism":  "none"
    }
}
optim_config = {
	"weights_bw"	: {
		"min"	: 6,
		"max"	: 6
	},
	"neurons_bw"	: {
		"min"	: 9,
		"max"	: 9
	},
	"fp_dec"	: {
		"min"	: 5,
		"max"	: 5
	}
}

####################################
# Seed setting for reproducibility #
####################################
seed = config_seed
random.seed(seed)                 # Python built-in RNG
np.random.seed(seed)              # NumPy RNG
torch.manual_seed(seed)           # CPU RNG
torch.cuda.manual_seed(seed)      # GPU RNG (single GPU)
torch.cuda.manual_seed_all(seed)  # GPU RNG (all GPUs)
torch.backends.cudnn.deterministic = True
torch.backends.cudnn.benchmark = False

##############
# Parameters #
##############
TRAIN =             True
batch_size =        64
n_epochs =          30
data_dir =          "Mnist/data"
output_dir =        "output"
SD_PATH =           "./Trained/trained_state_dict.pt"

#########
# Setup #
#########
logging.basicConfig(level=logging.INFO)
data_loader = MnistDL(data_dir = data_dir, num_steps = net_config_best["n_cycles"])
train_loader, test_loader = data_loader.load(batch_size = batch_size)
net_builder = NetBuilder(net_config_best)  # Create the network
snn = net_builder.build()           # Build snn model

#########
# Train #
#########
if (TRAIN):
    trainer = Trainer(snn)
    trainer.train(train_loader, test_loader, n_epochs = n_epochs, store=True)
else:
    state_dict = torch.load(SD_PATH, weights_only=True)
    snn.load_state_dict(state_dict)

############
# Optimize #
############
opt = Optimizer(snn, net_config_best, optim_config)
_ = opt.optimize(test_loader)
optim_config = {}
optim_config["weights_bw"] 	= int(input("Pick the best weights bitwidth: "))
optim_config["neurons_bw"]	= int(input("Pick the best neurons bitwidth: "))
optim_config["fp_dec"]		= int(input("Pick the best number of fixed point digits: "))

########
# VHDL #
########
vhdl_generator = VhdlGenerator(snn, optim_config)
vhdl_snn  = vhdl_generator.generate(functional=False, interface=True)
write_vhdl(vhdl_snn, rm=True,  output_dir = output_dir)

