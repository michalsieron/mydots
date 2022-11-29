#!/bin/sh

strict_env

# Creates proxy script in .direnv/aliases that calls aliased program
export_alias() {
    ALIAS_NAME="$1"
    shift
    ALIAS_VALUE="$*"

    layout bin aliases
    TARGET=".direnv/aliases/$ALIAS_NAME"

    cat > "$TARGET" << EOF
#!/usr/bin/env bash

exec $ALIAS_VALUE "\$@"
EOF

    chmod +x "$TARGET"
}
