#!/usr/bin/env bash

source ./lib/utils.sh

[[ ! -d "$HOME/.config" ]] && mkdir -pv "$HOME/.config"

[[ ! -d "$HOME/.local/bin" ]] && mkdir -pv "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

source ./modules/system.sh
source ./modules/fonts.sh
source ./modules/gpu.sh
source ./modules/docker.sh
source ./modules/bun.sh
source ./modules/neovim.sh
source ./modules/fish.sh
source ./modules/desktop.sh

sudo mandb -q

install stow
stow warbacon -v

SCRIPT_PATH="$(realpath  "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

chmod +x "$SCRIPT_DIR"/bin/*
ln -sf "$SCRIPT_DIR"/bin/* "$HOME/.local/bin/"
