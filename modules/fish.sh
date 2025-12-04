#!/usr/bin/env bash

[[ -z $utils_loaded ]] && source ../lib/utils.sh

packages=(
    fish
    starship
    eza
)

install "${packages[@]}"
