import logging

from spikerplus.dataloaders import MnistDL
from spikerplus import Optimizer, NetBuilder, VhdlGenerator, Trainer
from spikerplus.vhdl import write_vhdl, compile_vhdl, elaborate_vhdl
from spikerplus.vhdl import NetworkSimulator

from configurations import *

from network_simulator import NetworkSimulator

####################################
# Seed setting for reproducibility #
####################################
import torch
import numpy as np
import random
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
OPTIMIZER =         True                # If TRUE launch the optimizer to search for the best bitwidths
TRAIN =             True                # If TRUE train the network, otherwise load the state_dict from SD_PATH 
batch_size =        64
n_epochs =          2
data_dir =          "Mnist/data"                   
net_dict =          net_dict_75_lif
bitwidth_config =   bitwidth_config_6_10_10
output_dir =        "output-hardware-sim"
SD_PATH =           "./Trained/trained_state_dict.pt"

#########
# Setup #
#########
logging.basicConfig(level=logging.INFO)
data_loader = MnistDL(data_dir = data_dir, num_steps = net_dict["n_cycles"])
train_loader, test_loader = data_loader.load(batch_size = batch_size)
net_builder = NetBuilder(net_dict)  # Create the network
snn = net_builder.build()           # Build snn model

# Print dataloaders sizes
logging.info(f"Train loader size: {len(train_loader)}")
logging.info(f"Test loader size: {len(test_loader)}")

# Print data loaders element shape and batch size
first_train_batch = next(iter(train_loader))
first_test_batch = next(iter(test_loader))

logging.info(f"Train loader element shape: {first_train_batch[0].shape}, labels shape: {first_train_batch[1].shape}")
logging.info(f"Test loader element shape: {first_test_batch[0].shape}, labels shape: {first_test_batch[1].shape}")

# Print test loader batch size (number of samples in a batch)
logging.info(f"Test loader batch size: {first_test_batch[0].shape[0]}")

# Print total number of samples in test set (approximate)
total_test_samples = len(test_loader) * first_test_batch[0].shape[0]
logging.info(f"Approximate total number of test samples: {total_test_samples}")


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
if (OPTIMIZER):
    opt = Optimizer(snn, net_dict, optim_config)
    _ = opt.optimize(test_loader)
    optim_config = {}
    optim_config["weights_bw"] 	= int(input("Pick the best weights bitwidth: "))
    optim_config["neurons_bw"]	= int(input("Pick the best neurons bitwidth: "))
    optim_config["fp_dec"]		= int(input("Pick the best number of fixed point digits: "))

########
# VHDL #
########
vhdl_generator = VhdlGenerator(snn, optim_config) if OPTIMIZER else VhdlGenerator(snn, bitwidth_config)
vhdl_snn  = vhdl_generator.generate(functional=True, interface=False)
write_vhdl(vhdl_snn, rm=True,  output_dir = output_dir)
compile_vhdl(vhdl_snn, output_dir = output_dir)
elaborate_vhdl(vhdl_snn, output_dir = output_dir)

vhdl_sim = NetworkSimulator(vhdl_snn)
vhdl_sim.simulate(test_loader, sim_duration = "200us")
