#!/usr/bin/env bash

[[ -z $utils_loaded ]] && source ../lib/utils.sh

packages=(
    adobe-source-han-sans-jp-fonts
    gnu-free-fonts
    inter-font
    noto-fonts-emoji
    ttf-google-sans-code-vf
    ttf-nerd-fonts-symbols
)

install "${packages[@]}"
