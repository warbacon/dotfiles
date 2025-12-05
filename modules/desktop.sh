#!/usr/bin/env bash

[[ -z $utils_loaded ]] && source ../lib/utils.sh

packages=(
    ffmpegthumbnailer
    foot
    gnome-keyring
    hunspell-es_es
    hypridle
    libnotify
    localsend-bin
    loupe
    mako
    nautilus
    nautilus-open-any-terminal
    niri
    papers
    pulsemixer
    rofi
    swww
    uwsm
    vicinae-bin
    waybar
    wl-clipboard
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    xdg-terminal-exec
    xdg-user-dirs
    xwayland-satellite
    zen-browser-bin
)

install "${packages[@]}"

xdg-user-dirs-update --set TEMPLATES "$HOME"
xdg-user-dirs-update --set PUBLICSHARE "$HOME"
xdg-user-dirs-update --set MUSIC "$HOME"

sudo glib-compile-schemas /usr/share/glib-2.0/schemas
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface accent-color teal
gsettings set org.gnome.desktop.interface font-name "Inter 10"
gsettings set org.gnome.desktop.wm.preferences button-layout appmenu:none
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal "$(xdg-terminal-exec --print-cmd)"

sudo systemctl set-default graphical.target
