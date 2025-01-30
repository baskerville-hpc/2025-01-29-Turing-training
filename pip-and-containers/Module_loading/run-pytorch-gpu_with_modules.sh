#!/bin/bash
#SBATCH --qos arc
#SBATCH --account edmondac-rsg
#SBATCH --time 1:0:0
#SBATCH --nodes 1
#SBATCH --gpus 2 
#SBATCH --cpus-per-gpu 72
#SBATCH --open-mode=truncate
#SBATCH --output run-pytorch-gpu_with_modules_output

module purge
module load baskerville
module load bask-apps/live/live
module load bask-apps/live
module load PyTorch/2.1.2-foss-2023a-CUDA-12.1.1

#added -u to flush output to buffer.
python -u pytorch-gpu.py
