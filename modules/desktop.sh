#!/usr/bin/env bash

[[ -z $utils_loaded ]] && source ../lib/utils.sh

packages=(
    app2unit
    hunspell-es_es
    libnotify
    loupe
    nautilus
    niri
    papers
    swww
    uwsm
    waybar
    wl-clipboard
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    xdg-terminal-exec
    xdg-user-dirs
    xdg-utils
    zen-browser-bin
)

install "${packages[@]}"
xdg-user-dirs-update --set TEMPLATES "$HOME" --set PUBLICSHARE "$HOME" --set MUSIC "$HOME"
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface accent-color teal
gsettings set org.gnome.desktop.interface font-name "Inter 10"
gsettings set org.gnome.desktop.wm.preferences button-layout appmenu:none
gsettings set org.gnome.desktop.wm.preferences button-layout appmenu:none
sudo systemctl set-default graphical.target
