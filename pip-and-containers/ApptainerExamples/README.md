# Apptainer Examples for Baskerville

# Introduction

Here are three Baskerville Apptainer examples - these are:

+ A simple Python "Hello World" example
+ An example which calls nvidia-smi allowing you to see what CUDA is being used on the compute node and other details.
+ A PyTorch example which uses pip to install PyTorch, do some basic maths and check that the GPU is being used

The first of these is based on the Alpine docker image, and the second and third on the Debian Stable-slim docker image.

I've included two slurm scripts for each project, one which builds on a compute node (trying to be a responsible citizen!) and one to run the container on a compute node. Currently in the last two cases the build slurm isn't working as there is a problem accessing /tmp on Baskerville.

There are some extra considerations for working like this

+ make sure you run **unset APPTAINER_BIND** in every shell you're running in.
+ In the build script, **build --force** means you don't have to deal with the "Would you like to overwrite this image?" dialog.
+ In the def file, prepending all apt commands with **DEBIAN_FRONTEND=noninteractive** protects you from lockups due to a command asking for user input
+ In pip commands, add **--no-cache-dir** to prevent pip complaining about access to /tmp directories.

If you have any issues or suggestions, please get in touch with j.allsopp@bham.ac.uk