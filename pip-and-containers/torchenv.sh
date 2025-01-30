FUNDL_DIR="FUNDL_DIR"
mkdir $FUNDL_DIR
cd $FUNDL_DIR/

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
 

 module load bask-apps/live
 module load OpenMPI/4.1.5-GCC-12.3.0
 module load bask-apps/live
 module load OpenMPI/4.1.5-GCC-12.3.0
 module load NCCL/2.18.3-GCCcore-12.3.0-CUDA-12.1.1
 module load Python/3.11.3-GCCcore-12.3.0
 python -m venv hug_env
 
  ACTIVATE_FILE="$SCRIPT_DIR/$FUNDL_DIR/hug_env/bin/activate"
  newline40=" module load Python/3.11.3-GCCcore-12.3.0" #
  echo -e "add line 40 ${newline40} to ${ACTIVATE_FILE}"
  a="40i" 
  sed -i  "${a}\\${newline40}" "${ACTIVATE_FILE}"
  newline40="module load NCCL/2.18.3-GCCcore-12.3.0-CUDA-12.1.1" #
  echo -e "add line 40 ${newline40} to ${ACTIVATE_FILE}"
  a="40i" 
  sed -i  "${a}\\${newline40}" "${ACTIVATE_FILE}"
  newline40="module load OpenMPI/4.1.5-GCC-12.3.0" #
  echo -e "add line 40 ${newline40} to ${ACTIVATE_FILE}"
  a="40i" 
  sed -i  "${a}\\${newline40}" "${ACTIVATE_FILE}"
  newline40="module load bask-apps/live" #
  echo -e "add line 40 ${newline40} to ${ACTIVATE_FILE}"
  a="40i" 
  sed -i  "${a}\\${newline40}" "${ACTIVATE_FILE}"
 
  source ./hug_env/bin/activate

  pip install --upgrade pip
 
  which python
  which pip3
  pwd -P
  python -c "from huggingface_hub import model_info; print(model_info('gpt2'))"
  pip install 'huggingface_hub[tensorflow]'
  pip install 'huggingface_hub[cli,fastai,torch]'
 
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"$SCRIPT_DIR/$FUNDL_DIR/hug_env/lib"
  source ./hug_env/bin/activate
  pip3 install tensorrt_llm==0.8.0 -U --extra-index-url https://pypi.nvidia.com
  export HUGGINGFACE_HUB_CACHE="$SCRIPT_DIR/$FUNDL_DIR/" 
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"$SCRIPT_DIR/$FUNDL_DIR/hug_env/lib"
 