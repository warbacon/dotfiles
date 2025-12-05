#!/usr/bin/env bash

sudo -v

source ./lib/utils.sh

[[ ! -d "$HOME/.config" ]] && mkdir -pv "$HOME/.config"

[[ ! -d "$HOME/.local/bin" ]] && mkdir -pv "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

run_logged ./modules/system.sh
run_logged ./modules/fonts.sh
run_logged ./modules/gpu.sh
run_logged ./modules/docker.sh
run_logged ./modules/bun.sh
run_logged ./modules/neovim.sh
run_logged ./modules/fish.sh
run_logged ./modules/desktop.sh
run_logged ./modules/laptop.sh

info "Building mandb..."
sudo mandb -q

info "Doing stow things..."
install stow
stow warbacon -v
