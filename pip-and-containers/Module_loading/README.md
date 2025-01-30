# Running the same code using Conda or Module loading

This repository shows how to run the same code (*pytorch-gpu.py*) by either using [conda](https://anaconda.org/anaconda/conda) or using module loading. It is important to stress that module loading is the Baskerville Team's preferred way of working as the module will be compiled with optimisations for Baskerville's configuration, and will be smaller due to having irrelevant options removed. If a module is missing, please contact us at *baskerville-tier2-support@contacts.bham.ac.uk* and we may be able to build it.

However, if time is short and you really need the latest and greatest, using conda is an option. Whichever option you choose, you will need to change the *account* and *qos* in the following slurm scripts;

+ run-pytorch-gpu_with_conda.sh
+ run-pytorch-gpu_with_modules.sh

You will also need to change the file *conda_env.sh* to point to a location outside your home directory where you can store the conda environment. To create the conda environment, you can run this slurm script. It should take about 10 minutes to run.

```
sbatch create_conda_env.sh
```

Once that has finished successfully (you can look in the create_conda_output and create_conda_output.stats files to check),  you can run the conda version of this with
```
sbatch run-pytorch-gpu_with_conda.sh
```

which will output to (however many times you run this, it will output to the same files over-writing what is there. This isn't the standard slurm behavior) 

+ run-pytorch-gpu_with_conda_output
+ run-pytorch-gpu_with_conda_output.stats

The first of these contains the output for a single GPU. Only one module is needed here explicitly, as the conda environment does the work. 

```
Miniconda3/4.10.3
Is cuda available True
__CUDNN VERSION: 8902
__Number CUDA Devices: 1
__CUDA Device Name: NVIDIA A100-SXM4-40GB
__CUDA Device Total Memory [GB]: 42.298834944
```

The stats file gives information about the length of time it took to run, the resources it required, and how it exited; either successfully or with a fail.

The module loading version, which runs on two GPUs (hence will take a bit longer to start), can be run with;

```
sbatch run-pytorch-gpu_with_modules.sh
```

which will output to 

+ run-pytorch-gpu_with_modules_output
+ run-pytorch-gpu_with_modules_output.stats

The first of these should contain the following;
```
GCCcore/12.2.0
<lots of modules not shown here>
PyTorch/2.1.2-foss-2022b-CUDA-11.8.0
Is cuda available True
__CUDNN VERSION: 8700
__Number CUDA Devices: 2
__CUDA Device Name: NVIDIA A100-SXM4-80GB
__CUDA Device Total Memory [GB]: 84.98774016
__CUDA Device Name: NVIDIA A100-SXM4-80GB
__CUDA Device Total Memory [GB]: 84.98774016

```

and you can clearly see the two GPUs we requested. We asked for them to be on a single node to simplify things, otherwise we would have had to run the code on each node. You can also see that the CUDNN_VERSION is close between the two examples, but that the conda version is more recent (8902 vs 8700).