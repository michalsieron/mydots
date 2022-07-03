#!/usr/bin/env bash

# history
export HISTCONTROL=ignoreboth
export HISTFILESIZE=-1
shopt -s histappend

SHELL_NAME=bash source "$HOME/.profile"
