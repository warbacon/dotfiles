#!/usr/bin/env bash

sudo -v

source ./lib/utils.sh

ensure_dir "$HOME/.config"
ensure_dir "$HOME/.local/bin"
export PATH="$HOME/.local/bin:$PATH"

info "Stowing..."
install stow
stow warbacon -v || exit 1

run_logged ./modules/system.sh
run_logged ./modules/docker.sh
run_logged ./modules/bun.sh
run_logged ./modules/neovim.sh
if ! is_available wslinfo; then
    run_logged ./modules/gpu.sh
    run_logged ./modules/fonts.sh
    run_logged ./modules/desktop.sh
fi
if grep Battery /sys/class/power_supply/*/type &>/dev/null; then
    run_logged ./modules/laptop.sh
fi

info "Building man database..."
sudo mandb -q
