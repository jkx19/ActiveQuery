<!-- <p align="center">
  <img src="https://raw.githubusercontent.com/huggingface/alignment-handbook/main/assets/handbook.png">
</p>

<p align="center">
    🤗 <a href="https://huggingface.co/collections/alignment-handbook/handbook-v01-models-and-datasets-654e424d22e6880da5ebc015" target="_blank">Models & Datasets</a> | 📃 <a href="https://arxiv.org/abs/2310.16944" target="_blank">Technical Report</a>
</p> -->

# The Alignment Handbook

## Installation instructions

To run the code in this project, first, create a Python virtual environment using e.g. Conda:

```shell
conda create -n handbook python=3.10 && conda activate handbook
```

Next, install PyTorch `v2.1.0` - the precise version is important for reproducibility! Since this is hardware-dependent, we
direct you to the [PyTorch Installation Page](https://pytorch.org/get-started/locally/).

You can then install the remaining package dependencies as follows:

```shell
git clone https://github.com/huggingface/alignment-handbook.git
cd ./alignment-handbook/
python -m pip install .
```

You will also need Flash Attention 2 installed, which can be done by running:

> **Note**
> If your machine has less than 96GB of RAM and many CPU cores, reduce the MAX_JOBS., e.g. `MAX_JOBS=4 pip install flash-attn --no-build-isolation`

```shell
python -m pip install flash-attn --no-build-isolation
```

Next, log into your Hugging Face account as follows:

```shell
huggingface-cli login
```

Finally, install Git LFS so that you can push models to the Hugging Face Hub:

```shell
sudo apt-get install git-lfs
```

You can now check out the `scripts` and `recipes` directories for instructions on how to train some models 🪁!

## Project structure

```
├── LICENSE
├── Makefile                    <- Makefile with commands like `make style`
├── README.md                   <- The top-level README for developers using this project
├── chapters                    <- Educational content to render on hf.co/learn
├── recipes                     <- Recipe configs, accelerate configs, slurm scripts
├── scripts                     <- Scripts to train and evaluate chat models
├── setup.cfg                   <- Installation config (mostly used for configuring code quality & tests)
├── setup.py                    <- Makes project pip installable (pip install -e .) so `alignment` can be imported
├── src                         <- Source code for use in this project
└── tests                       <- Unit tests
```

## Running 

First checkout `recipes/zephyr-7b-beta/dpo/config_lora.yaml` and set the following arguments. gradient_accumulation_steps, loss_type (choose from "corr", "sigmoid", "hinge") and data_selection (true for ADPO and false for DPO) and per_device_train_batch_size. Then edit --num_processes in `pipeline.sh`. Make sure gradient_accumulation_steps\*per_device_train_batch_size\*num_processes=true_batch_size. Then run the following command in shell:

```
bash pipeline.sh
```
