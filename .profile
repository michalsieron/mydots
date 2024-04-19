#!/usr/bin/sh

# XDG_*_HOME variables
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_CACHE_HOME="${HOME}/.cache"
XDG_RUNTIME_DIR="/run/user/$(id -u)"
export XDG_RUNTIME_DIR

# use $HOME/.xprofile for this
[ "$(basename -- "$0")" = "Xsession" ] && return

# non-starship prompt
PS1="\[\033[01;36m\]\w\[\033[01;32m\]\n\$\[\033[00m\] "

# shellcheck disable=SC1091
[ -f "$HOME/.xdg_ninja" ] && . "$HOME/.xdg_ninja"
# shellcheck disable=SC1091
[ -f "$HOME/.exports" ] && . "$HOME/.exports"
# shellcheck disable=SC1091
[ -f "$HOME/.aliases" ] && . "$HOME/.aliases"

if [ "$SHELL_NAME" ]; then
    do_init() {
        if cmd-exists "$1"; then
            eval "$("$@")"
        else
            echo "Couldn't init '$1'. Command doesn't exist!" >&2
        fi
    }

    do_init mcfly init "$SHELL_NAME"
    do_init zoxide init "$SHELL_NAME"
    do_init starship init "$SHELL_NAME"
    do_init direnv hook "$SHELL_NAME"

    unset -f do_init
fi

if cmd-exists vim; then
    export EDITOR=vim
else
    export EDITOR=vi
fi

if ! mydots diff --quiet HEAD FETCH_HEAD; then
    echo "mydots local vs remote mismatch!" >&2
fi
