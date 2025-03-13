# mydots

This repo contains my dotfiles for Arch Linux based distributions

# Installation

To install `mydots` first clone this as a bare repo:
```
git clone --bare https://github.com/michalsieron/mydots mydots
```
Then switch to `main` branch:
```
git --git-dir mydots --work-tree . switch main
```
Git will warn you if there are any files that would be overwritten.
You must remove them first.

If you want to overwrite all conflicting files, you can run:
```
git --git-dir mydots --work-tree . reset --hard main
```

On next shell launch, its config should be loaded.

# Notable features

- `mydots` alias for interacting with `mydots` repo
- systemd user service auto-updating `mydots` repo every 5 minutes
- `zigup` script for managing Zig compiler installations
- `tmux-renode` script for launching [renode](https://renode.io) in tmux window

# Dependencies

For shells other than `/bin/sh`:
- [fzf](https://github.com/junegunn/fzf)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [starship](https://github.com/starship/starship)
- [miniconda](https://docs.conda.io/en/latest/miniconda.html)

Editor: `vi` or `vim`

For `zigup.sh`: `xz-utils`, `curl`, `jq` and `grep` with support for `-P` flag
