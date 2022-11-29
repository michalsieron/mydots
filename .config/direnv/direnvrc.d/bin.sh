#!/bin/sh

strict_env

# Creates given directory (or bin if omitted) and then adds it to the PATH
layout_bin() {
    DIR=".direnv/${1:-bin}"
    mkdir -p "$DIR"
    PATH_add "$DIR"
}
