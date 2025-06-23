# Parameter Exploration Scripts

This directory contains a collection of scripts used for parameter exploration and fine-tuning during the training process. The scripts are intentionally minimalistic, as they modularly leverage the exploratory nature and flexibility of the `spiker` framework.
Each script is designed to investigate the impact of a specific hyperparameter or training configuration, particularly those requiring further empirical analysis beyond default settings.

## Contents

- **Exploration Scripts**: Each script targets a distinct training parameter. It defines a fixed network configuration and performs a sweep over one critical parameter. The script repeatedly invokes the `spiker` tool and collects the results for subsequent analysis.
- **`optimizer.py`**: A modified version of the optimizer from the `spiker` module. The primary difference is that this version returns a dictionary containing additional metadata useful for logging, analysis, and tracking during exploratory runs.
