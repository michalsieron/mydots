#!/bin/sh

strict_env

layout_conda() {
    layout bin
    if [ ! -d .direnv/conda ]; then
        echo "Downloading miniconda..."
        curl -L https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh | \
            bash -s -- -b -p .direnv/conda
    fi

    unstrict_env # disable to check if variable is defined
    if [ -z "$1" ] && [ -f environment.yml ]; then
        ENV_FILE=environment.yml
    elif [ -z "$1" ] && [ ! -f environment.yml ]; then
        ENV_FILE=""
    elif [ -f "$1" ]; then
        ENV_FILE="$1"
    else
        die "Environment file: $ENV_FILE doesn't exist. Aborting!"
    fi
    strict_env # re-enable strict env after doing the check

    # find line with env name
    # quotes are optional (using hex values to avoid escaping)
    # if name is `base`, then value will be empty
    if [ -f "$ENV_FILE" ]; then
        ENV_NAME="$(sed -nE 's/^name:\s+([\x22\x27]?)(.*?)\1$/\2/; t l; /./d; :l /base/d; /./p' "$ENV_FILE")"
    else
        ENV_NAME="conda-env"
    fi

    ENV_PREFIX="$PWD/.direnv/conda/${ENV_NAME:+envs/$ENV_NAME}"
    if [ ! -d "$ENV_PREFIX" ]; then
        conda create -p "$ENV_PREFIX" -f "$ENV_FILE" -y
    fi

    unstrict_env eval "$(conda shell.posix activate -p "$ENV_PREFIX")"
}
