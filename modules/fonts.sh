#!/usr/bin/env bash

[[ -z $utils_loaded ]] && source ../lib/utils.sh

packages=(
    inter-font
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    ttf-google-sans-code-vf
    ttf-nerd-fonts-symbols
)

install "${packages[@]}"
