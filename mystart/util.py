import os
from urllib.request import urlretrieve
from pathlib import Path
import shutil
import subprocess

home_dir = str(Path.home())


def info(text: str):
    print(f"\033[34;1mMYSTART:\033[0m \033[1m{text}...\033[0m")


def warn(text: str):
    print(f"\033[33;1mMYSTART:\033[0m \033[1m{text}\033[0m")


def error(text: str):
    print(f"\033[31;1mMYSTART:\033[0m \033[1m{text}\033[0m")
    exit(1)


def git_clone(repo: str, dir: str):
    if not repo.startswith("https://"):
        repo = f"https://github.com/{repo}"

    info(f"Cloning {repo} in {dir}")
    _ = subprocess.run(["git", "clone", "--depth=1", repo, dir])


def command_exists(cmd: str) -> bool:
    return shutil.which(cmd) is not None


def package_exists(pkg: str) -> bool:
    return (
        subprocess.run(
            ["pacman", "-Q", pkg], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
        ).returncode
        == 0
    )


def install_packages(pkgs: str | list[str], asdeps: bool = False):
    if isinstance(pkgs, str):
        pkgs = [pkgs]

    pkgs_to_remove: list[str] = []

    for pkg in pkgs:
        if package_exists(pkg):
            pkgs_to_remove.append(pkg)

    for pkg in pkgs_to_remove:
        pkgs.remove(pkg)

    if len(pkgs) == 0:
        return

    if not command_exists("paru"):
        git_clone("https://aur.archlinux.org/paru-bin.git", "/tmp/paru-bin")
        _ = subprocess.run(["makepkg", "-si"], cwd="/tmp/paru-bin")

    command = ["paru", "-Sq", "--needed", "--noconfirm"]

    pkgs_str = ", ".join(pkgs)

    if asdeps:
        command.append("--asdeps")
        info(f"Installing {pkgs_str} as dependencies")
    else:
        info(f"Installing {pkgs_str}")

    try:
        subprocess.run(command + pkgs).check_returncode()
    except subprocess.CalledProcessError:
        error(f"Failed to install the following packages: {pkgs_str}")


def gsettings_set(path: str, key: str, value: str):
    if not command_exists("gsettings"):
        install_packages("glib2")

    command = ["gsettings", "set", path, key, value]
    info(f"Executing {' '.join(command)}")

    _ = subprocess.run(command)


def create_directory(path: str):
    try:
        info(f"Trying to create directory '{path}'")
        os.mkdir(path)
    except FileExistsError:
        warn(f"Directory '{path}' already exists.")


def download_file(url: str, path: str = "") -> str:
    filename: str = os.path.basename(url)
    if path == "":
        path = f"/tmp/{filename}"
    info(f"Downloading {filename} in {path}")
    try:
        _ = urlretrieve(url, path)
        info(f"Successfully downloaded {filename}")
    except Exception as e:
        error(f"Failed to download file: {e}")

    return path
