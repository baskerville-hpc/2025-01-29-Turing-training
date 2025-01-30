#!/bin/bash
#SBATCH --qos arc
#SBATCH --account edmondac-rsg
#SBATCH --time 1:0:0
#SBATCH --nodes 1
#SBATCH --gpus 1 
#SBATCH --cpus-per-gpu 36
#SBATCH --open-mode=truncate
#SBATCH --output run-pytorch-gpu_with_conda_output

module purge
module load baskerville
module load bask-apps/live
module load Miniconda3/4.10.3

source conda_env.sh

eval "$(${EBROOTMINICONDA3}/bin/conda shell.bash hook)"  # initialise conda
conda activate "${conda_env}"
python -u pytorch-gpu.py
