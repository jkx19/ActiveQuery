<!-- <p align="center">
  <img src="https://raw.githubusercontent.com/huggingface/alignment-handbook/main/assets/handbook.png">
</p>

<p align="center">
    🤗 <a href="https://huggingface.co/collections/alignment-handbook/handbook-v01-models-and-datasets-654e424d22e6880da5ebc015" target="_blank">Models & Datasets</a> | 📃 <a href="https://arxiv.org/abs/2310.16944" target="_blank">Technical Report</a>
</p> -->

# Active Direct Preference Optimization (ADPO)

This repository contains the official code for the paper "[Reinforcement Learning from Human Feedback with Active Queries](https://arxiv.org/abs/2402.09401)".

Authors: Kaixuan Ji*, Jiafan He*, Quanquan Gu


## About ADPO

Active Direct Preference Optimization (ADPO) serves as a query-efficient alternative to direct prefernce optimization (DPO). More Specifically, at each training step, ADPO first compute estimate the model's uncertainty of each preference pair. ADPO only queries for the preference labels of those pairs with low confidence scores. For the pairs with high confidence scores, ADPO uses the predicted preference label (pseudo-label) to update the model. Experiments on Zephyr-β and Zephyr-gemma shows that ADPO matches the performance of DPO with only one quarters of queries needed. You can check our [paper](https://arxiv.org/abs/2402.09401) for more details.

## Environment Setup

The following steps provide the necessary setup to run our codes. First, create a conda environment as follows

```
conda create -n adpo python=3.10.9
conda activate adpo
```

Next, install the required packages as follows

```
python3 -m pip install -e .
```

## Reproducing Results

To reproduce the results in our paper, please follow the steps below. To replicate the results on Zephyr-β, please run the following command.

```
ACCELERATE_LOG_LEVEL=info accelerate launch --config_file recipes/accelerate_configs/deepspeed_zero3.yaml --num_processes=8 --main_process_port 30000 scripts/run_dpo.py recipes/zephyr-7b-beta/dpo/config_full.yaml \
--beta=0.1 \
--data_selection=true \
--Gamma=1.3 \
--num_train_epochs=1 \
--output_dir={path_to_your_output_dir}
```
To replicate the results on Zephyr-gemma, please run the following command.

```
ACCELERATE_LOG_LEVEL=info accelerate launch --config_file recipes/accelerate_configs/deepspeed_zero3.yaml --num_processes=8 --main_process_port 30000 scripts/run_dpo.py recipes/zephyr-7b-gemma/dpo/config_full.yaml \
--beta=0.1 \
--data_selection=true \
--Gamma=1.3 \
--num_train_epochs=1 \
--output_dir={path_to_your_output_dir}
```

In both commands, `\beta` is the weight of the KL divergence term in the loss function, and `data_selection` is a boolean flag to enable active querying. When active-querying is enabled, `Gamma` is the confidence threshold $\gamma$ for active querying. Please refer to the [recipe file for Zephyr-β](recipes/zephyr-7b-beta/dpo/config_full.yaml) or [recipe file for Zephyr-gemma](recipes/zephyr-7b-beta/dpo/config_full.yaml) for more details about the hyperparameters.

The evaluation is based on the official repositories of [Open LLM Leaderboard](GitHub - EleutherAI/lm-evaluation-harness: A framework for few-shot evaluation of language models.), [AlpacaEval](GitHub - tatsu-lab/alpaca_eval: An automatic evaluator for instruction-following language models. Hu) and [MT-Bench](FastChat/fastchat/llm_judge at main · lm-sys/FastChat). We refer to the official repositories for more details about the evaluation procedure.

## Citation

If you find this repository helpful, please kindly cite our paper:

```bibtex
@article{ji2024reinforcement,
  title={Reinforcement learning from human feedback with active queries},
  author={Ji, Kaixuan and He, Jiafan and Gu, Quanquan},
  journal={arXiv preprint arXiv:2402.09401},
  year={2024}
}
```

## Acknowledgement

This repo is built upon The [Alignment Handbook](GitHub - huggingface/alignment-handbook: Robust recipes to align language models with human and AI p). We thank the authors for their great work.