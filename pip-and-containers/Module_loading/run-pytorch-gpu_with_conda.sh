#!/bin/bash
#SBATCH --account vjgo8416-training25
#SBATCH --qos turing
#SBATCH --time 1:0:0
#SBATCH --nodes 1
#SBATCH --gpus 1 
#SBATCH --cpus-per-gpu 36
#SBATCH --open-mode=truncate
#SBATCH --output run-pytorch-gpu_with_conda_output

module purge
module load baskerville
module load bask-apps/live
module load Miniforge3/24.1.2-0
source conda_env.sh
export OMP_NUM_THREADS=56

eval "$($EBROOTMINIFORGE3/bin/conda shell.bash hook)"
source "$EBROOTMINIFORGE3/etc/profile.d/mamba.sh"
python -u pytorch-gpu.py
