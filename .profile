#!/usr/bin/sh

# non-starship prompt
PS1="\[\033[01;36m\]\w\[\033[01;32m\]\n\$\[\033[00m\] "

if [ "$SHELL_NAME" ]; then
    do_init() {
        type "$1" > /dev/null && eval "$("$@")"
    }

    do_init mcfly init "$SHELL_NAME"
    do_init zoxide init "$SHELL_NAME"
    do_init starship init "$SHELL_NAME"
    do_init "$HOME/miniconda/bin/conda" "shell.$SHELL_NAME" hook

    unset -f do_init
fi

if type vim > /dev/null; then
    export EDITOR=vim
else
    export EDITOR=vi
fi

# shellcheck disable=SC1091
[ -f "$HOME/.aliases" ] && . "$HOME/.aliases"
# shellcheck disable=SC1091
[ -f "$HOME/.exports" ] && . "$HOME/.exports"

if ! mydots diff --quiet HEAD FETCH_HEAD; then
    echo "mydots local vs remote mismatch!" >&2
fi
