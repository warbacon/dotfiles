#!/usr/bin/env bash

sudo pacman -S base-devel --needed --noconfirm

git clone https://aur.archlinux.org/paru.git /tmp/paru
makepkg -si -D /tmp/paru
