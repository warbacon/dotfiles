#!/usr/bin/env bash

[[ -z $utils_loaded ]] && source ../lib/utils.sh

packages=(
    7zip
    bash-completion
    btop
    chafa
    dust
    eza
    fastfetch
    fd
    ffmpeg
    fish
    fzf
    gcc
    hyperfine
    imagemagick
    jq
    lazygit
    less
    libqalculate
    man-db
    man-pages-es
    nodejs-lts-krypton
    npm
    ripgrep
    starship
    tlrc-bin
    tmux
    tokei
    trash-cli
    unrar
    unzip
    wget
    xdg-utils
    yt-dlp
    zip
)

install "${packages[@]}"
sudo sed -i 's/#Color/Color/g' /etc/pacman.conf
sudo sed -i '/^OPTIONS=/ { /!debug/! s/\bdebug\b/!debug/ }' /etc/makepkg.conf
