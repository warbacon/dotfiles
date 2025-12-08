#!/usr/bin/env bash

[[ -z $utils_loaded ]] && source ../lib/utils.sh

packages=(
    adobe-source-han-sans-jp-fonts
    inter-font
    noto-fonts-emoji
    ttf-dejavu
    ttf-google-sans-code-vf
    ttf-liberation
    ttf-nerd-fonts-symbols
)

install "${packages[@]}"
