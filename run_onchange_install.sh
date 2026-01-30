#!/usr/bin/env bash

pkg_install() {
    paru -S --needed --noconfirm "$@"
}

packages=(
    base-devel
    bash-completion
    man-db
    man-pages
    man-pages-es

    7zip
    btop
    dust
    fastfetch
    fd
    fish
    fzf
    github-cli
    hyperfine
    lazygit
    opencode-bin
    ripgrep
    skim
    starship
    tmux
    trash-cli
    tree
    unzip
    wget

    bob
    tree-sitter-cli
    bash-language-server
    shellcheck
    shfmt
    lua-language-server
    stylua
    vscode-css-languageserver
    vscode-html-languageserver
    vscode-json-languageserver
    yaml-language-server
    clang
    taplo-cli

    niri
    xdg-desktop-portal-gnome
    xwayland-satellite
    foot
    hyprpicker
    mako
    quickshell

    fuse2
    libnotify
    ly
    pulsemixer
    wl-clipboard
    xdg-terminal-exec

    localsend-bin
    loupe
    nautilus
    nautilus-open-any-terminal
    papers

    mpv
    yt-dlp

    app2unit
    gnome-keyring
    vicinae-bin

    hunspell-es_es
    speech-dispatcher
    zen-browser-bin

    adobe-source-han-sans-otc-fonts
    adwaita-fonts
    noto-fonts-emoji
    ttf-dejavu
    ttf-google-sans-code-vf
    ttf-liberation
    ttf-nerd-fonts-symbols
)

# PACMAN CONFIG
sudo sed -i 's/#Color/Color/g' /etc/pacman.conf
sudo sed -i '/^OPTIONS=/ { /!debug/! s/\bdebug\b/!debug/ }' /etc/makepkg.conf

# X11 KEYMAP (FOR XWAYLAND)
localectl set-x11-keymap es

# INSTALL PACKAGES
pkg_install "${packages[@]}"

# vmware
if [[ "$(systemd-detect-virt)" = "vmware" ]]; then
    pkg_install open-vm-tools
    sudo systemctl enable --now vmtoolsd.service
else
    pkg_install rocm-smi-lib vulkan-radeon
fi

# Laptop
if [[ "$HOSTNAME" = "zenarch" ]]; then
    pkg_install bluez tlp bluetui brightnessctl
    sudo systemctl enable --now bluetooth.service
    sudo systemctl enable --now tlp.service
fi

# BOB
bob use nightly

# GNOME SETTINGS
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface font-name "sans-serif 10"
gsettings set org.gnome.desktop.wm.preferences button-layout appmenu:none

# TERMINAL
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal "$(xdg-terminal-exec --print-cmd)"
xdg-mime default "$(xdg-terminal-exec --print-id)" x-scheme-handler/terminal

# SERVICES
sudo systemctl enable ly@tty1.service
systemctl enable --user --now foot-server.socket
systemctl enable --user --now vicinae.service

# MANDB
echo "Rebuilding man database..."
sudo mandb -q
