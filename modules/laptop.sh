#!/usr/bin/env bash

[[ -z $utils_loaded ]] && source ../lib/utils.sh

packages=(
    adw-bluetooth
    brightnessctl
    tlp
)

install "${packages[@]}"
sudo systemctl enable --now tlp.service
