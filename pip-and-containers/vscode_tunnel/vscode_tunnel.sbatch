#!/bin/bash

#SBATCH --ntasks 8
#SBATCH --nodes 1
#SBATCH --time 0-1  # run for 1 hour
#SBATCH --account vjgo8416-training25
#SBATCH --qos turing

set -e

module purge; module load baskerville

# add any required module loads here, e.g. a specific Python

CLI_PATH="${HOME}/vscode_cli"

# Install the VS Code CLI command if it doesn't exist
if [[ ! -e ${CLI_PATH}/code ]]; then
    echo "Downloading and installing the VS Code CLI command"
    mkdir -p "${HOME}/vscode_cli"
    pushd "${HOME}/vscode_cli"
    # Process from: https://code.visualstudio.com/docs/remote/tunnels#_using-the-code-cli
    curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz
    # unpack the code binary file
    tar -xf vscode_cli.tar.gz
    # clean-up
    rm vscode_cli.tar.gz
    popd
fi

# run the code tunnel command and accept the licence
${CLI_PATH}/code tunnel --accept-server-license-terms
