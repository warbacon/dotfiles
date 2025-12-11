#!/usr/bin/env bash

[[ -z $utils_loaded ]] && source ../lib/utils.sh

packages=(
    ccache
    cmake
    fd
    gcc
    ninja
    ripgrep
    tree-sitter-cli
    base-devel
)

tools=(
    bash-language-server
    jdtls
    lua-language-server
    shellcheck
    shfmt
    stylua
    vscode-json-languageserver
    yaml-language-server
)

install "${packages[@]}" "${tools[@]}"
github_clone warbacon/nvim-config "$HOME/.config/nvim"

is_package_installed neovim && yay -Rns neovim --noconfirm
is_available nvim && return

ensure_dir "$HOME/Git"
[[ ! -d "$HOME/Git/neovim" ]] \
    && git clone --branch nightly https://github.com/neovim/neovim "$HOME/Git/neovim"

pushd "$HOME/Git/neovim" && {
    make CMAKE_EXTRA_FLAGS="-DCMAKE_BUILD_TYPE=Release -DENABLE_TRANSLATIONS=ON"
    sudo make install
    popd || return
}
