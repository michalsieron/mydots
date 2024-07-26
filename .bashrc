#!/usr/bin/env bash

# history
export HISTCONTROL=ignoreboth
export HISTSIZE=-1
export HISTFILESIZE=-1
shopt -s histappend

SHELL_NAME=bash source "$HOME/.profile"
