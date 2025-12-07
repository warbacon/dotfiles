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

ensure_yay() {
    if ! command -v yay &>/dev/null; then
        sudo pacman -S base-devel --needed --noconfirm
        git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
        pushd /tmp/yay-bin && {
            makepkg -si --noconfirm --needed
            popd || exit 1
            rm -rfv /tmp/yay-bin
        }
    fi
}

is_installed() {
    ensure_yay
    yay -Qq "$1" &>/dev/null || command -v "$1" &>/dev/null
}

install() {
    ensure_yay

    local packages_to_install=()
    for package in "$@"; do
        is_installed "$package" || packages_to_install+=("$package")
    done

    if ((${#packages_to_install[@]} > 0)); then
        yay -S "${packages_to_install[@]}" --noconfirm --needed
    fi
}

info() {
    echo -e "\033[1;34mINFO:\033[0m $@"
}

run_logged() {
    info "Running $1..."
    source "$1"
}

ensure_dir() {
    [[ ! -d "$1" ]] && mkdir -pv "$1"
}

github_clone() {
    [[ ! -d "$2" ]] && git clone https://github.com/"$1" "$2"
}
