import logging

from spikerplus.dataloaders import MnistDL
from spikerplus import Optimizer, NetBuilder, VhdlGenerator, Trainer
from spikerplus.vhdl import write_vhdl, compile_vhdl, elaborate_vhdl
from spikerplus.vhdl import NetworkSimulator

from configurations import *

# Set the random seed for reproducibility
import torch
import numpy as np
import random

seed = 85
random.seed(seed)                 # Python built-in RNG
np.random.seed(seed)              # NumPy RNG
torch.manual_seed(seed)           # CPU RNG
torch.cuda.manual_seed(seed)      # GPU RNG (single GPU)
torch.cuda.manual_seed_all(seed)  # GPU RNG (all GPUs)
torch.backends.cudnn.deterministic = True
torch.backends.cudnn.benchmark = False

# Parameters for current run
OPTIMIZER = True                        # TRAINING CONF
TRAIN = True                           # TRAINING CONF
batch_size = 64
n_epochs = 20
data_dir = "Mnist/data"                   
net_dict = net_dict_75               # NET CONF
bitwidth_config = bitwidth_config_75_97_52_lif
output_dir = "output_75_86_26"                   # VHDL CONF
SD_PATH = "./Trained/trained_state_dict.pt"

# Print progress at the different steps
logging.basicConfig(level=logging.INFO)

data_loader = MnistDL(data_dir = data_dir, num_steps = net_dict["n_cycles"])
train_loader, test_loader = data_loader.load(batch_size = batch_size)

net_builder = NetBuilder(net_dict)  # Create the network
snn = net_builder.build()           # Build snn model

if (TRAIN):
    trainer = Trainer(snn)              # Instantiate trainer
    # TRAIN (set store to 'True' to save state dict)
    trainer.train(train_loader, test_loader, n_epochs = n_epochs, store=True)
else:
    #snn = torch.load(SD_PATH, weights_only=False)

    # load parameters into the model, don't overwrite it
    state_dict = torch.load(SD_PATH, weights_only=True)
    snn.load_state_dict(state_dict)

# OPTIMIZE
if (OPTIMIZER):
    opt = Optimizer(snn, net_dict, optim_config)
    _ = opt.optimize(test_loader)
    optim_config = {}
    optim_config["weights_bw"] 	= int(input("Pick the best weights bitwidth: "))
    optim_config["neurons_bw"]	= int(input("Pick the best neurons bitwidth: "))
    optim_config["fp_dec"]		= int(input("Pick the best number of fixed point digits: "))

# Generate the VHDL code
vhdl_generator = VhdlGenerator(snn, optim_config) if OPTIMIZER else VhdlGenerator(snn, bitwidth_config)
vhdl_snn  = vhdl_generator.generate(functional=False, interface=True)

write_vhdl(vhdl_snn, rm=True,  output_dir = output_dir)
compile_vhdl(vhdl_snn, output_dir = output_dir)
elaborate_vhdl(vhdl_snn, output_dir = output_dir)
