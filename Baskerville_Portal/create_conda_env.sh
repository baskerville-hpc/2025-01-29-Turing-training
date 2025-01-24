#!/bin/bash

set -e

## Function
project_check () {
  echo -e "Checking if you are in a project space"
  if echo "$(pwd -P)" | grep -q "project";
  then
      echo "Running script in project space"
  else
      echo -e "Running script in home space, please run script in a project location"
      exit
  fi
}

# Check you are on a GPU
gpu_check () {
  echo -e "Checking if you are on a GPU"
  export GPU_FLAG=$(echo -e "${SLURM_GPUS_ON_NODE}")
  if [[ $(echo -e "${GPU_FLAG}") -gt 0 ]];
  then
      echo -e "Running on a GPU"
  else
      echo -e "This application requires a GPU"
      exit
  fi
}

## Function call
project_check
gpu_check



TRAINING_BASE=$(pwd -P)

# Check that the team ID env var is set
#if [ ! -d "${TEAM_PROJ_BASE}" ]; then
#  echo -e "Please enter correct path as ${TEAM_PROJ_BASE} does not exist"
#  exit 1
#fi

if [ -d "${TRAINING_BASE}/portal_env" ]; then
  echo "Conda envirnment already exists"
  echo "Delete if you want to rebuild your conda environment"
  else
    echo "Creating conda environment for challenge this can take a few minutes"
    # Basic module setup
    module purge; module load baskerville
    module load bask-apps/live

    # Load and enable the Miniforge module
    module load Miniforge3/24.1.2-0
    eval "$(${EBROOTMINIFORGE3}/bin/conda shell.bash hook)"

    # Define the path to your team's project space (modify as appropriate)
    CONDA_ENV_PATH="${TRAINING_BASE}/portal_env"

    # Ensure that Conda stores its downloaded content in /tmp, instead of the default which is
    # the user's home directory
    export CONDA_PKGS_DIRS="/tmp"

    # Create the environment. Only required once. Build from environment file
    conda create --yes --prefix "${CONDA_ENV_PATH}"

    conda activate "${CONDA_ENV_PATH}"

    conda install --yes python=3.10

    conda install --yes nvidia/label/cuda-12.1.1::cuda-toolkit

    conda install --yes nvidia/label/cuda-12.1.1::cuda-nvcc

    conda install --yes nvidia/label/cuda-12.1.1::cuda-runtime

    conda install --yes -c pytorch -c nvidia pytorch torchvision torchaudio pytorch-cuda=12.1 

    conda install --yes -c conda-forge transformers

    conda install -c rapidsai -c conda-forge jupyterlab-nvdashboard

    pip install --upgrade pip

    pip install accelerate

    echo -e "Installation complete"
fi

# Automatically adding conda path into $USER .conda space
# Checking if envrionments.txt file exists
if [ ! -f ${HOME}/.conda/environments.txt ]; then
  echo -e "Creating conda environment ${TRAINING_BASE}/portal_env"
  echo -e "${TRAINING_BASE}/portal_env" >>${HOME}/.conda/environments.txt
# If file exists will still check that this file contains this conda path
  else if [[ $(cat ${HOME}/.conda/environments.txt | grep -e ${TRAINING_BASE}/portal_env) == ${TRAINING_BASE}/portal_env ]]; then
    echo "Environment already exists"
    else
      echo -e "Creating conda environment ${TRAINING_BASE}/portal_env"
      echo -e "${TRAINING_BASE}/portal_env" >>${HOME}/.conda/environments.txt
  fi
fi
# Final show user list of conda environments
echo -e "`cat ${HOME}/.conda/environments.txt`"
