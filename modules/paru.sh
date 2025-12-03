#!/usr/bin/env bash

[[ -z $utils_loaded ]] && source ../lib/utils.sh

sudo sed s/#BottomUp/BottomUp/g /etc/paru.conf -i

is_installed paru && return

install base-devel
git clone https://aur.archlinux.org/paru-bin.git
pushd paru-bin && {
    makepkg -si --noconfirm --needed
    popd || exit 1
    rm -rf paru-bin/
}
