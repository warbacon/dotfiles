import subprocess
from mystart.util import gsettings_set, install_packages

pkgs = [
    "bibata-cursor-theme-bin",
    "bluetui",
    "brightnessctl",
    "cliphist",
    "dunst",
    "grim",
    "hypridle",
    "hyprland",
    "hyprlock",
    "hyprpaper",
    "hyprsunset",
    "kitty",
    "libcanberra",
    "libnotify",
    "pulsemixer",
    "rofi-wayland",
    "rofimoji",
    "slurp",
    "uwsm",
    "waybar",
    "wl-clip-persist",
    "wtype",
    "xdg-desktop-portal-gtk",
    "xdg-desktop-portal-hyprland",
    "xdg-user-dirs",
    "yazi",
]

install_packages(pkgs)
_ = subprocess.run(["xdg-user-dirs-update"])
gsettings_set("org.gnome.desktop.wm.preferences", "button-layout", "appmenu:none")
