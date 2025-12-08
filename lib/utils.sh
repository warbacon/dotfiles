#!/usr/bin/env bash

export utils_loaded=1

info() {
    echo -e "\033[1;34mINFO:\033[0m $*"
}

ensure_yay() {
    if ! command -v yay &>/dev/null; then
        info "Installing yay..."
        sudo pacman -S base-devel --needed --noconfirm --quiet
        git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
        pushd /tmp/yay-bin && {
            makepkg -si --noconfirm --needed
            popd || exit 1
            rm -rf /tmp/yay-bin
        }
    fi
}

is_package_installed() {
    ensure_yay
    yay -Qq "$1" &>/dev/null
}

is_available() {
    command -v "$1" &>/dev/null
}

is_installed() {
    is_package_installed "$1" || is_available "$1"
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
