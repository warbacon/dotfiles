#!/usr/bin/env bash

[[ -z $utils_loaded ]] && source ../lib/utils.sh

packages=(
    neovim
    gcc
    fd
    ripgrep
    tree-sitter-cli
)

install "${packages[@]}"
[[ ! -d "$HOME/.config/nvim" ]] && git clone https://github.com/warbacon/nvim-config "$HOME/.config/nvim"
