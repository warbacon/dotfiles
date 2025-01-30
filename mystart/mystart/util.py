from dataclasses import dataclass
from enum import Enum
import os
from urllib.request import urlretrieve
from pathlib import Path
import shutil
import subprocess

home_dir = str(Path.home())


class LogLevel(Enum):
    INFO = "\033[34;1m"  # Blue
    WARN = "\033[33;1m"  # Yellow
    ERROR = "\033[31;1m"  # Red


@dataclass
class Logger:
    PREFIX: str = "MYSTART:"

    @staticmethod
    def _log(level: LogLevel, text: str, exit_on_error: bool = False) -> None:
        print(f"{level.value}{Logger.PREFIX}\033[0m \033[1m{text}\033[0m")
        if exit_on_error:
            exit(1)

    @classmethod
    def info(cls, text: str) -> None:
        cls._log(LogLevel.INFO, f"{text}...")

    @classmethod
    def warn(cls, text: str) -> None:
        cls._log(LogLevel.WARN, text)

    @classmethod
    def error(cls, text: str, exit_on_error: bool = True) -> None:
        cls._log(LogLevel.ERROR, text, exit_on_error)


def git_clone(repo: str, dir: str):
    if not repo.startswith("https://"):
        repo = f"https://github.com/{repo}"

    Logger.info(f"Cloning {repo} in {dir}")
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
        _ = subprocess.run(["makepkg", "-si", "--noconfirm"], cwd="/tmp/paru-bin")

    command = ["paru", "-Sq", "--needed", "--noconfirm"]

    pkgs_str = ", ".join(pkgs)

    if asdeps:
        command.append("--asdeps")
        Logger.info(f"Installing {pkgs_str} as dependencies")
    else:
        Logger.info(f"Installing {pkgs_str}")

    try:
        subprocess.run(command + pkgs).check_returncode()
    except subprocess.CalledProcessError:
        Logger.error(f"Failed to install the following packages: {pkgs_str}")


def gsettings_set(path: str, key: str, value: str):
    if not command_exists("gsettings"):
        install_packages("glib2")

    command = ["gsettings", "set", path, key, value]
    Logger.info(f"Executing {' '.join(command)}")

    _ = subprocess.run(command)


def create_directory(path: str):
    try:
        Logger.info(f"Trying to create directory '{path}'")
        os.mkdir(path)
    except FileExistsError:
        Logger.warn(f"Directory '{path}' already exists.")


def download_file(url: str, path: str = "") -> str:
    filename: str = os.path.basename(url)
    if path == "":
        path = f"/tmp/{filename}"
    Logger.info(f"Downloading {filename} in {path}")
    try:
        _ = urlretrieve(url, path)
        Logger.info(f"Successfully downloaded {filename}")
    except Exception as e:
        Logger.error(f"Failed to download file: {e}")

    return path
