#!/usr/bin/env bash

[[ -z $utils_loaded ]] && source ../lib/utils.sh

is_installed bun && return

readonly BUN_FILE="bun-linux-x64-baseline"
readonly BUN_URL="https://github.com/oven-sh/bun/releases/latest/download/$BUN_FILE.zip"
readonly INSTALL_DIR="$HOME/.local/bin"

install unzip

curl -o "/tmp/$BUN_FILE.zip" \
    --fail \
    --progress-bar \
    --location \
    "$BUN_URL"

unzip -o "/tmp/$BUN_FILE.zip" -d "/tmp/"
cp -v "/tmp/$BUN_FILE/bun" "$INSTALL_DIR/"

[[ ! -e "$INSTALL_DIR/bunx" ]] && ln -sv "$INSTALL_DIR/bun" "$INSTALL_DIR/bunx"

rm -rf "/tmp/${BUN_FILE:?}"*
