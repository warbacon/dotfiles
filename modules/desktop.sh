#!/usr/bin/env bash

[[ -z $utils_loaded ]] && source ../lib/utils.sh

packages=(
    app2unit
    brightnessctl
    foot
    hunspell-es_es
    hypridle
    libnotify
    loupe
    mako
    nautilus
    niri
    papers
    rofi
    swww
    uwsm
    waybar
    wl-clipboard
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    xdg-terminal-exec
    xdg-user-dirs
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
