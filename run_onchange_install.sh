#!/usr/bin/env bash

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
    fzf
    github-cli
    hyperfine
    lazygit
    ripgrep
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
    quickshell
    mako
    hyprpicker

    fuse2
    libnotify
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

sudo sed -i 's/#Color/Color/g' /etc/pacman.conf
sudo sed -i '/^OPTIONS=/ { /!debug/! s/\bdebug\b/!debug/ }' /etc/makepkg.conf

yay -S --needed --noconfirm "${packages[@]}"

if [[ "$(systemd-detect-virt)" = "vmware" ]]; then
    yay -S --needed --noconfirm open-vm-tools
    sudo systemctl enable --now vmtoolsd.service
else
    yay -S --needed --noconfirm rocm-smi-lib vulkan-radeon
fi

if [[ "$HOSTNAME" = "zenarch" ]]; then
    yay -S --needed --noconfirm bluez tlp bluetui brightnessctl
    sudo systemctl enable --now bluetooth.service
    sudo systemctl enable --now tlp.service
fi

bob use nightly

gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal "$(xdg-terminal-exec --print-cmd)"
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface font-name "sans-serif 10"
gsettings set org.gnome.desktop.wm.preferences button-layout appmenu:none

xdg-mime default "$(xdg-terminal-exec --print-id)" x-scheme-handler/terminal

systemctl enable --user --now foot-server.socket
systemctl enable --user --now vicinae.service

echo "Rebuilding man database..."
sudo mandb -q
