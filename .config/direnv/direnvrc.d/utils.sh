#!/bin/sh

strict_env

# Writes message to stderr and exits with error code 1
die() {
    echo "$@" >&2
    exit 1
}
