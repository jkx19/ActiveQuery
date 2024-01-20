export HF_HOME="/data/jkx/.cache/"
export CUDA_VISIBLE_DEVICES="6,7"

# EDIT data_selection, Gamma in config.yaml

ACCELERATE_LOG_LEVEL=info accelerate launch --config_file recipes/accelerate_configs/multi_gpu.yaml --num_processes=2 --main_process_port 29500 scripts/run_dpo.py recipes/zephyr-7b-beta/dpo/config_lora.yaml
