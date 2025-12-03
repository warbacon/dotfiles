#!/usr/bin/env bash

[[ -z $utils_loaded ]] && source ../lib/utils.sh

packages=(
    7zip
    chafa
    fastfetch
    fd
    fzf
    gcc
    github-cli
    hyperfine
    lazygit
    less
    man-db
    man-pages-es
    ripgrep
    tlrc-bin
    tmux
    trash-cli
    unzip
    wget
    xdg-user-dirs
    xdg-utils
)

install "${packages[@]}"
xdg-user-dirs-update --set TEMPLATES "$HOME" --set PUBLICSHARE "$HOME" --set MUSIC "$HOME"
sudo sed s/#Color/Color/g /etc/pacman.conf -i
