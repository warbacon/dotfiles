from mystart.util import git_clone, install_packages, home_dir

pkgs = [
    "base-devel",
    "fd",
    "neovim-nightly-bin",
    "npm",
    "ripgrep",
    "ttf-nerd-fonts-symbols",
    "unzip",
    "wget",
    "wl-clipboard",
]

install_packages(pkgs)
git_clone("warbacon/nvim-config", home_dir + "/.config/nvim")
