# MNIST Challenge ICIP 2025

## Introduction

This project addresses the [Digit Recognition Low Power and Speed Challenge](https://mlunglma.github.io/challenge.html#overview) at **ICIP 2025**, aiming at developing an FPGA-based accelerator capable of performing efficient and accurate handwritten digit recognition. Specifically, our solution leverages **[Spiker+](https://github.com/alessiocarpegna/spikerplus)**, an open-source framework designed for the rapid development, optimization, and deployment of **Spiking Neural Networks** (**SNNs**) on **FPGA** platforms. The main objective is optimizing classification accuracy, inference speed, and energy efficiency by exploring design trade-offs between SNN complexity and FPGA resource constraints.

--  ADD A REFERENCE TO THE PAPER

## 📁 Repository Structure

```bash
├── mnist.py                        # python script for Spiker flow
├── README.md                       # README file
├── challenge_environment.yml       # conda environment
├── configurations.py               # configuration file for mnist.py script
├── constraints.xdc                 # xdc constraints file
├── images
│   └── workflow.png                
├── mnist_optuna.py                 # optuna script
└── output                          # output folder with hdl (.vhd) and memory coefficient files (.coe)
    ├── *.vhd
    ├── *.coe

```

## Project Workflow Overview

The workflow involves four main phases:

1. **[Software Exploration](#software-exploration)**: Define the initial SNN model and train using surrogate gradient methods in PyTorch (via **[SnnTorch](https://github.com/jeshraghian/snntorch)** and **[Optuna](https://github.com/optuna/optuna)**). Rapidly evaluate various architectures and neuron models for accuracy and computational efficiency.

2. **[Quantization & HDL Generation (Spiker+)](#quantization--hdl-generation-spiker)**: Perform quantization exploration and optimization using **Spiker+**, identifying optimal numerical precision (bit-widths) for neurons and synaptic weights.
Automatically generate synthesizable VHDL code from the optimized model.

3. **[Hardware Deployment (Vivado)](#hardware-deployment-vivado)**: Integrate the generated VHDL architecture directly into a Vivado project. Configure the FPGA constraints using a dedicated `.xdc` file. Target FPGA platform: `Xilinx Kintex XC7K160TFBG484-1`.

4. **Evaluation**: Verify performance metrics: inference accuracy, latency, throughput, and resource utilization using Vivado synthesis reports.

![Workflow](./images/workflow.png)

## 🔍 Software Exploration

Prior to hardware generation, hyperparameter exploration was performed using **Optuna**, integrated with the **Spiker+** software stack. The foundation of our model development is **PyTorch**, which provides the core tensor operations and training infrastructure. On top of this, we used **SnnTorch**, a PyTorch-based library specifically designed for training **Spiking Neural Networks** (**SNNs**) using surrogate gradient methods. SnnTorch seamlessly supports neuron dynamics, spike generation, and BPTT-compatible training workflows.

Optuna systematically searched the hyperparameter space, evaluating diverse configurations (layer size, neuron type, training specific parameters) to determine optimal trade-offs. This exploration phase is purely software-driven, with the goal of maximizing model accuracy before any hardware constraints are considered. The selection criterion for promoting a configuration to the hardware design phase was strictly set to models achieving a test accuracy ≥ 97.5%.

## 🔧 Quantization & HDL Generation (Spiker+)

### Environment Setup

To ensure **reproducibility** and **deterministic** execution, we fixed the random seed for Python, NumPy, and PyTorch. This is essential due to stochastic operations (e.g., Poisson-based spike encoding, random weight initialization).

```python
import torch
import numpy as np
import random

seed = 85
random.seed(seed)
np.random.seed(seed)
torch.manual_seed(seed)
torch.cuda.manual_seed(seed)
torch.cuda.manual_seed_all(seed)
torch.backends.cudnn.deterministic = True
torch.backends.cudnn.benchmark = False
```

### Configuration Parameters

The script begins by defining key **parameters** and settings:

```python
OPTIMIZER = False                                   # Enable or disable quantization optimization
TRAIN = False                                       # Enable or disable training
batch_size = 64                                     # Training batch size
n_epochs = 20                                       # Training epochs
data_dir = "Mnist/data"                             # Dataset folder
net_dict = net_dict_75                              # Network configuration
bitwidth_config = bitwidth_config_75_86_26_lif      # Bitwidth configuration
output_dir = "output_75_86_26"                      # Save output from script
SD_PATH = "./Trained/trained_state_dict.pt"         # Save trained model parameter
```

### Data Loading (MNIST)

We load the MNIST dataset and convert it into spike trains using Poisson-based rate coding:

```python
from spikerplus.dataloaders import MnistDL

data_loader = MnistDL(data_dir=data_dir, num_steps=net_dict["n_cycles"])
train_loader, test_loader = data_loader.load(batch_size=batch_size)
```

### Building the SNN Model

The network is defined and instantiated using **Spiker+** (PyTorch-based SNN model):

```python
from spikerplus import NetBuilder

net_builder = NetBuilder(net_dict)
snn = net_builder.build()
```

### Training the SNN

If `TRAIN=True`, the network undergoes supervised training, employing surrogate-gradient-based **Back-Propagation Through Time** (**BPTT**):

```python
if TRAIN:
    from spikerplus import Trainer
    trainer = Trainer(snn)
    trainer.train(train_loader, test_loader, n_epochs=n_epochs, store=True)
else:
    state_dict = torch.load(SD_PATH)
    snn.load_state_dict(state_dict)
```

At the end of the training phase, if the `store=True` parameter is defined, the trained state dict is saved for later inference.

### Optimization via Quantization (Optuna Integration)

If `OPTIMIZER=True`, **Spiker+** performs quantization exploration for future hardware development:

```python
if OPTIMIZER:
    from spikerplus import Optimizer
    opt = Optimizer(snn, net_dict, optim_config)
    _ = opt.optimize(test_loader)

    optim_config["weights_bw"] = int(input("Pick best weights bitwidth: "))
    optim_config["neurons_bw"] = int(input("Pick best neurons bitwidth: "))
    optim_config["fp_dec"] = int(input("Pick best number of fixed-point digits: "))
```

### HDL Generation for FPGA

Post-training and optimization, the network is converted into synthesizable **VHDL**. **Spiker+** generates VHDL for FPGA deployment, tailored specifically to network quantization and hardware constraints. The output is structured for **FPGA** synthesis, including neuron models, memories, and interfaces.:

```python
from spikerplus import VhdlGenerator
from spikerplus.vhdl import write_vhdl, compile_vhdl, elaborate_vhdl

vhdl_generator = VhdlGenerator(snn, optim_config if OPTIMIZER else bitwidth_config)
vhdl_snn = vhdl_generator.generate(functional=False, interface=True)

write_vhdl(vhdl_snn, rm=True, output_dir=output_dir)
compile_vhdl(vhdl_snn, output_dir=output_dir)
elaborate_vhdl(vhdl_snn, output_dir=output_dir)
```

## ⚙️ Hardware Deployment (Vivado)

The final optimized **Hardware Description Language** (**HDL**) is automatically generated by the Spiker+ framework. The resulting **VHDL** code is stored within the project’s output directory, as defined by the script parameter `output_dir = "output"`.

This folder contains the full SNN accelerator architecture, including:

 * **Neuron models** (Leaky Integrate-and-Fire, optimized for FPGA efficiency).
 * **Network parameters** stored in `.coe` files for ROM memory initialization.

### Vivado Project Integration

To deploy the architecture on FPGA hardware:

1. **Vivado Project Setup**: Create a new Vivado project.
2. **Select FPGA board**: Xilinx Kintex `XC7K160TFBG484-1` from the Vivado *Parts* list.
3. **Constraints (XDC File)**: The provided `.xdc` constraints file defines physical pin mappings and clock frequency. It ensures correct timing and hardware integration.
4. **Memory Initialization (.coe Files)**: Generated by Spiker+ to initialize internal memory, these .coe files must be loaded into Vivado's Block RAM memory IPs. The user must istantiate the memory using the **BRAM** block from the IP Library and then load each ROM with the given `.coe` files.
5. **Synthesis and Implementation**: Finally run Vivado synthesis and implementation processes to generate the final FPGA bitstream and evaluate the results in terms of Power Consumption, Resource utilization and Maximum Clock Frequency. Along with the implementation results running the Functional simulation it is possibile to evaluate the latency of the accelerator.

## 🧪 Test the workflow

To test and reproduce the full workflow, begin by setting up the environment:

1. **Initialize the Conda Environment**: Use the provided `.yml` file to create a reproducible software environment:

```bash
conda env create -f environment.yml
conda activate spiker-env
```

2. **Run the Software Pipeline**: You can execute the Optuna-based exploration script to test how different network configurations affect accuracy, latency, and resource utilization. Most importantly, run the main pipeline script `python mnist.py`.
This script loads or trains the SNN model, it applies quantization (if enabled), it generates the VHDL files and finally saves trained weights and hardware description into the specified output directory.

3. **Open Vivado for Hardware Deployment**: Launch Vivado and create a new project. Select the target FPGA part: XC7K160TFBG484-1, add the generated VHDL files from the `output/` folder as project sources, add the provided `.xdc` constraints file to map I/O signals and use the generated `.coe` initialization files to instantiate and initialize ROM memories (typically using the Block Memory Generator IP).

4. **Synthesize and Implement the Design**: Run synthesis and implementation in Vivado to generate the final bitstream. This step finalizes the design and allows you to program the FPGA for live testing.