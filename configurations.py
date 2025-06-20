
##########################
# LIST OF CONFIGURATIONS #
##########################

# CONFIGURATIONS COMING FROM SPARX
net_smallest_lif = {
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
bitwidth_smallest_lif = {
    "weights_bw": 10,
    "neurons_bw": 10,
    "fp_dec": 6
}

# SpikeExplorer LIF Configuration
net_dict_se_lif = {
    "n_cycles": 10,
    "n_inputs": 784,
    "layer_0": {
        "neuron_model": "lif",
        "n_neurons": 200,
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
bitwidth_config_se_lif = {
    "weights_bw": 5,
    "neurons_bw": 7,
    "fp_dec": 6
}

# Small Network Experiment Configuration
net_dict_100 = {
    "n_cycles":             10,
    "n_inputs":             784,
    "layer_0": {
        "neuron_model":     "lif",
        "n_neurons":        100,
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
# 97.5 % CONFIG
bitwidth_config_100_97_5_lif = {
    "weights_bw": 6,
    "neurons_bw": 9,
    "fp_dec": 5
}
# BEST 97.78 % CONFIG
bitwidth_config_100_97_78_lif = {
    "weights_bw": 10,
    "neurons_bw": 10,
    "fp_dec": 6
}
# WORST 73.53 % CONFIG
bitwidth_config_100_min_lif = {
    "weights_bw": 4,
    "neurons_bw": 4,
    "fp_dec": 4
}

# Small Network Experiment Configuration
net_dict_75 = {
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
# 97.61 % CONFIG
bitwidth_config_75_97_61_lif = {
    "weights_bw": 6,
    "neurons_bw": 9,
    "fp_dec": 5
}
# BEST 97.78 % CONFIG
bitwidth_config_75_97_86_lif = {
    "weights_bw": 10,
    "neurons_bw": 10,
    "fp_dec": 6
}
# WORST 73.53 % CONFIG
bitwidth_config_75_86_26_lif = {
    "weights_bw": 4,
    "neurons_bw": 4,
    "fp_dec": 4
}
# WORST 73.53 % CONFIG
bitwidth_config_75_97_52_lif = {
    "weights_bw": 6,
    "neurons_bw": 8,
    "fp_dec": 5
}

# SpikeExplorer RLIF Configuration
net_dict_se_rlif = {
    "n_cycles": 25,
    "n_inputs": 784,
    "layer_0": {
        "neuron_model": "rlif",
        "n_neurons": 200,
        "beta": 0.9375,
        "learn_beta": False,
        "threshold": 1.0,
        "learn_threshold": False,
        "reset_mechanism": "subtract"
    },
    "layer_1": {
        "neuron_model": "rlif",
        "n_neurons": 10,
        "beta": 0.9375,
        "learn_beta": False,
        "threshold": 1.0,
        "learn_threshold": False,
        "reset_mechanism": "none"
    }
}
bitwidth_config_se_rlif = {
    "weights_bw": 5,
    "neurons_bw": 7,
    "fp_dec": 6
}

# Small Network Experiment Configuration
net_dict_small = {
    "n_cycles": 10,
    "n_inputs": 784,
    "layer_0": {
        "neuron_model": "lif",
        "n_neurons": 80,
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
bitwidth_config_small = {
    "weights_bw": 5,
    "neurons_bw": 7,
    "fp_dec": 6
}

net_dict_rlif = {
    "n_cycles": 10,
    "n_inputs": 784,
    "layer_0": {
        "neuron_model": "rlif",
        "n_neurons": 200,
        "beta": 0.9375,
        "learn_beta": False,
        "threshold": 1.0,
        "learn_threshold": False,
        "reset_mechanism": "subtract"
    },
    "layer_1": {
        "neuron_model": "rlif",
        "n_neurons": 10,
        "beta": 0.9375,
        "learn_beta": False,
        "threshold": 1.0,
        "learn_threshold": False,
        "reset_mechanism": "none"
    }
}

net_dict_syn = {
    "n_cycles": 10,
    "n_inputs": 784,
    "layer_0": {
        "neuron_model": "syn",
        "n_neurons": 200,
        "beta": 0.9375,
        "learn_beta": False,
        "threshold": 1.0,
        "learn_threshold": False,
        "reset_mechanism": "subtract"
    },
    "layer_1": {
        "neuron_model": "syn",
        "n_neurons": 10,
        "beta": 0.9375,
        "learn_beta": False,
        "threshold": 1.0,
        "learn_threshold": False,
        "reset_mechanism": "none"
    }
}

net_dict_rsyn = {
    "n_cycles": 10,
    "n_inputs": 784,
    "layer_0": {
        "neuron_model": "rsyn",
        "n_neurons": 200,
        "beta": 0.9375,
        "learn_beta": False,
        "threshold": 1.0,
        "learn_threshold": False,
        "reset_mechanism": "subtract"
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

# Generic optimizer config for exploration
optim_config = {
	"weights_bw"	: {
		"min"	: 6,
		"max"	: 7
	},
	"neurons_bw"	: {
		"min"	: 7,
		"max"	: 8
	},
	"fp_dec"	: {
		"min"	: 5,
		"max"	: 6
	}
}
