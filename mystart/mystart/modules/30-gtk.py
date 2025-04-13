from mystart.util import (
    create_directory,
    gsettings_set,
    Logger,
    home_dir,
)

gsettings_set("org.gnome.desktop.interface", "color-scheme", "prefer-dark")
gsettings_set("org.gnome.desktop.interface", "font-name", "'Adwaita Sans 10'")

gtk3_dir = f"{home_dir}/.config/gtk-3.0"
gtk3_config = f"{gtk3_dir}/settings.ini"

create_directory(gtk3_dir)

with open(gtk3_config, "w") as f:
    Logger.info(f"Creating {gtk3_config}")
    # fmt: off
    _ = f.write(
"""[Settings]
gtk-application-prefer-dark-theme = true"""
    )
    # fmt: on
