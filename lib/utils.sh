#!/usr/bin/env bash

utils_loaded=1

is_installed() {
    command -v "$1" 2&>/dev/null
}

install() {
    if is_installed paru; then
        paru -S "$@" --noconfirm --needed
    else
        sudo pacman -S "$@" --noconfirm --needed
    fi
}
