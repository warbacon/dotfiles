#!/usr/bin/env bash

sudo pacman -S base-devel --needed --noconfirm

git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
makepkg -si -D /tmp/yay-bin
