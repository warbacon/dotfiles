from runpy import run_path
from mystart.util import download_file, install_packages

pkgs = [
    "python-dbus",
    "python-distro",
]

install_packages(pkgs)
path = download_file("https://eduroam.uca.es/software/eduroam-linux-UdC-Todos.py")
_ = run_path(path)
