#!/usr/bin/env bash

[[ -z $utils_loaded ]] && source ../lib/utils.sh

packages=(
    docker
    docker-compose
)

install "${packages[@]}"
sudo systemctl enable --now docker.socket
sudo usermod -aG docker "$USER"
