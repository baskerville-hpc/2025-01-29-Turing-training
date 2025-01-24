#!/bin/bash

# load baskerville modules for the virtual env
module load bask-apps/live                    #  
module load Python/3.9.5-GCCcore-10.3.0-bare  # using python 3.9.5 for our env 
module load CUDA/11.7.0                       # for nvidia-htop

# mk dir in current folder
mkdir mychillenv
# create the virtualenv
virtualenv mychillenv
# source the env 
source ./mychillenv/bin/activate

# pip install the software tools
pip install pip-chill
pip install arrow
pip install nvidia-htop

# Show use of pip-chill as opposed to pip freeze
echo "### pip-chill list package version "
pip-chill

echo "### pip-chill list packages without version "
pip-chill --no-version

echo "### pip-chill list package versions and package dependencies too "
pip-chill  --no-chill -v

# Show htop
echo "### nvidia-htop makes nvidia smi more readable "
nvidia-htop.py -l