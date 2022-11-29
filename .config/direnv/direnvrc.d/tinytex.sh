#!/bin/sh

strict_env

layout_tinytex() {
    layout bin

    TEXDIR="$PWD/.direnv/TinyTeX"

    if [ ! -d "$TEXDIR" ]; then
        if [ "$(uname -sm)" != "Linux x86_64" ]; then
            die "Unsupported platform!"
        fi

        TINYTEX_BUNDLE="${1:-TinyTeX-0}"
        unstrict_env # disable to check if variable is defined
        TINYTEX_VERSION="$2"
        strict_env # re-enable strict env after doing the check

        BASE_DOWNLOAD_URL="https://github.com/yihui/tinytex-releases/releases/download"
        if [ -z "$TINYTEX_VERSION" ]; then
            TINYTEX_URL="$BASE_DOWNLOAD_URL/daily/$TINYTEX_BUNDLE"
        else
            TINYTEX_URL="$BASE_DOWNLOAD_URL/v$TINYTEX_VERSION/$TINYTEX_BUNDLE-v$TINYTEX_VERSION"
        fi

        # download and extract the bundle
        curl -L "${TINYTEX_URL}.tar.gz" | tar xzf - -C .direnv/
        mv .direnv/.TinyTeX "$TEXDIR"

        "$TEXDIR/bin/x86_64-linux/tlmgr" postaction install script xetex  # GH issue #313
    fi

    PATH_add "$TEXDIR/bin/x86_64-linux"
}
