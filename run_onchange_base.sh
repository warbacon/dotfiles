#!/usr/bin/env bash

pkg_install() {
    paru -S --needed --noconfirm "$@"
}

packages=(
    base-devel
    bash-completion
    man-db
    man-pages
    man-pages-es

    7zip
    btop
    dust
    fastfetch
    fd
    fish
    fzf
    github-cli
    hyperfine
    lazygit
    opencode-bin
    ripgrep
    skim
    starship
    tlrc-bin
    tmux
    trash-cli
    tree
    unzip
    wget

    neovim-nightly-bin
    tree-sitter-cli
    bash-language-server
    shellcheck
    shfmt
    lua-language-server
    stylua
    vscode-css-languageserver
    vscode-html-languageserver
    vscode-json-languageserver
    yaml-language-server
    clang
    taplo-cli
)

# PACMAN CONFIG
sudo sed -i 's/#Color/Color/g' /etc/pacman.conf
sudo sed -i '/^OPTIONS=/ { /!debug/! s/\bdebug\b/!debug/ }' /etc/makepkg.conf

# INSTALL PACKAGES
pkg_install "${packages[@]}"
