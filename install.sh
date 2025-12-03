#!/usr/bin/env bash

source ./lib/utils.sh

source ./modules/paru.sh
source ./modules/system.sh
source ./modules/fonts.sh
source ./modules/vm.sh
source ./modules/docker.sh
source ./modules/neovim.sh
source ./modules/fish.sh
source ./modules/desktop.sh

mandb -q
stow warbacon/ -v
