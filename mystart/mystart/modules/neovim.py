import subprocess
from mystart.util import create_directory, git_clone, install_packages, home_dir

pkgs = [
    "fd",
    "gcc",
    "npm",
    "ripgrep",
    "ttf-nerd-fonts-symbols",
    "unzip",
    "wget",
    "wl-clipboard",
]

install_packages(pkgs)

git_repos_dir = f"{home_dir}/Git"
create_directory(git_repos_dir)
pkgbuild_dir = f"{git_repos_dir}/neovim-nightly-bin"
git_clone("warbacon/neovim-nightly-bin", pkgbuild_dir)
_ = subprocess.run(["makepkg", "-si", "--noconfirm"], cwd=pkgbuild_dir)

git_clone("warbacon/nvim-config", home_dir + "/.config/nvim")
