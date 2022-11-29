#!/bin/sh

strict_env

# Sets up conda environment with the given name
# If name is path to environment file, then it loads that file
# else if name is empty and environment.yml exists it loads it
# else it creates base environment with default channels
layout_mamba() {
    layout bin
    if [ ! -f .direnv/bin/micromamba ]; then
        echo "Downloading micromamba..."
        curl -L https://micro.mamba.pm/api/micromamba/linux-64/latest | \
            tar -xj -C .direnv/bin --strip-components=1 bin/micromamba
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
        micromamba create -r .direnv/conda -f "$(realpath "$ENV_FILE")" -y
    fi

    unstrict_env eval "$(micromamba shell activate -p "$ENV_PREFIX")"
    export MAMBA_ROOT_PREFIX="$PWD/.direnv/conda"
    export_alias conda "micromamba"
}
