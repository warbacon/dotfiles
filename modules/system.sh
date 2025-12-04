#!/usr/bin/env bash

[[ -z $utils_loaded ]] && source ../lib/utils.sh

packages=(
    7zip
    brightnessctl
    btop
    chafa
    fastfetch
    fd
    fzf
    gcc
    github-cli
    gnome-keyring
    hyperfine
    jq
    lazygit
    less
    man-db
    man-pages-es
    nodejs-lts-krypton
    npm
    ripgrep
    tlrc-bin
    tmux
    tokei
    trash-cli
    unzip
    wget
)

install "${packages[@]}"
sudo sed -i 's/#Color/Color/g' /etc/pacman.conf
sudo sed -i '/^OPTIONS=/s/debug //' /etc/makepkg.conf
