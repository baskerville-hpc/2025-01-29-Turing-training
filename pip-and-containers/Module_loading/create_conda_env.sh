#!/bin/bash
#SBATCH --qos arc
#SBATCH --account edmondac-rsg
#SBATCH --time 10:00
#SBATCH --nodes 1
#SBATCH --gpus 1
#SBATCH --cpus-per-gpu 36
#SBATCH --open-mode=truncate
#SBATCH --output create_conda_output

set -e

# Module loading
module purge; module load baskerville
module load bask-apps/live
module load Miniconda3/4.10.3

source conda_env.sh

eval "$(${EBROOTMINICONDA3}/bin/conda shell.bash hook)"  # initialise conda

#ENV_NAME=pytorch-env
export CONDA_ENV_PATH="${conda_env}"

export CONDA_PKGS_DIRS=/tmp

conda clean --all
conda create --yes --prefix ${CONDA_ENV_PATH}
conda activate ${CONDA_ENV_PATH}
conda install --yes pytorch torchvision torchaudio pytorch-cuda=12.1 --channel pytorch --channel nvidia
