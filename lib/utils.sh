#!/usr/bin/env bash

utils_loaded=1

ensure_paru() {
    if ! command -v paru &>/dev/null; then
        sudo pacman -S base-devel --needed --noconfirm
        git clone https://aur.archlinux.org/paru-bin.git /tmp/paru-bin
        pushd /tmp/paru-bin && {
            makepkg -si --noconfirm --needed
            popd || exit 1
            rm -rfv /tmp/paru-bin
        }

        sudo sed -i 's/#BottomUp/BottomUp/g' /etc/paru.conf
    fi
}

is_installed() {
    ensure_paru
    paru -Qq "$1" &>/dev/null || command -v "$1" &>/dev/null
}

install() {
    ensure_paru

    local packages_to_install=()
    for package in "$@"; do
        is_installed "$package" || packages_to_install+=("$package")
    done

    if ((${#packages_to_install[@]} > 0)); then
        paru -S "${packages_to_install[@]}" --noconfirm --needed
    fi
}
