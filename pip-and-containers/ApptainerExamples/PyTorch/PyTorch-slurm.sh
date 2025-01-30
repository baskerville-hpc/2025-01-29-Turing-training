#!/bin/bash

#SBATCH --account=<account name>
#SBATCH --qos=<qos>
#SBATCH --time 0:00:30  # Time assigned for the simulation
#SBATCH --nodes 1  # Normally set to 1 unless your job requires multi-node, multi-GPU
#SBATCH --gpus 1  # Resource allocation on Baskerville is primarily based on GPU requirement
#SBATCH --cpus-per-gpu 36  # This number should normally be fixed as "36" to ensure that the system resources are used effectively
#SBATCH --job-name nvidia-smi  # Title for the job

module purge
module load baskerville
#module load bask-apps/live
module load CUDA/11.3.1 

unset APPTAINER_BIND
apptainer run --nv PyTorch.sif



