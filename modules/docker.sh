#!/usr/bin/env bash

[[ -z $utils_loaded ]] && source ../lib/utils.sh

is_installed docker && return

packages=(
    docker
    docker-compose
)

install "${packages[@]}"
sudo systemctl enable --now docker.socket
sudo usermod -aG docker "$USER"
