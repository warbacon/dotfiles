# 👤 Dotfiles

_I'm back._

## ⁉️ What is this?

This repository contains a set of scripts for Arch Linux that ensure the system
is correctly configured every time `install.sh` is executed.

After using NixOS for a year, I built this system to smooth out some of the
rough edges from both NixOS and Arch, taking what I consider the best of each.
**This does *not* make the system reproducible** - if you need reproducibility,
please use NixOS...although let's be honest, who really needs _total_
reproducibility anyway?

## 📄 Details

- **Window manager**: Niri
- **Top bar**: Waybar
- **Application launcher**: Vicinae
- **Terminal**: Foot
- **Shell**: Fish
- **Text editor**: Neovim
- **File manager**: Nautilus
- **Notification daemon**: Mako

## 🚀 Try it out

> [!WARNING]
> This setup is designed specifically for **Arch Linux**.

> [!IMPORTANT]
> This setup is intended for **personal use**. Please **do not** run it on your
> existing system and perform a fresh install first.

To get started, simply run:

```sh
./install.sh
```

This will configure your system so that Niri launches automatically on each
login in TTY1.
