#!/usr/bin/env bash

source ./lib/utils.sh

source ./modules/system.sh
source ./modules/fonts.sh
source ./modules/gpu.sh
source ./modules/docker.sh
source ./modules/bun.sh
source ./modules/neovim.sh
source ./modules/fish.sh
source ./modules/desktop.sh

install stow

sudo mandb -q
stow warbacon/ -v

readonly SCRIPT_PATH="$(realpath  "$0")"
readonly SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

[[ ! -d "$HOME/.local/bin" ]] && mkdir -pv "$HOME/.local/bin"
chmod +x "$SCRIPT_DIR"/bin/*
ln -sf "$SCRIPT_DIR"/bin/* "$HOME/.local/bin/"
