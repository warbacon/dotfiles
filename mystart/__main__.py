from pathlib import Path
from runpy import run_path
from .util import error, info


def list_modules(directory: Path) -> list[str]:
    return [f.name for f in directory.glob("*.py")]


def get_user_selections(max_selection: int) -> list[int]:
    try:
        print("Modules to run (space-separated): ")
        input_str = input("> ")
        return [
            int(x.strip())
            for x in input_str.split(" ")
            if 1 <= int(x.strip()) <= max_selection
        ]
    except ValueError:
        print("Invalid input. Please enter valid numbers.")
        return []


def run_selected_modules(modules: list[str], modules_directory: Path):
    for module in modules:
        info(f"Running {modules_directory}/{module}")
        _ = run_path(f"{modules_directory}/{module}")


def main():
    base_dir = Path(__file__).parent
    modules_directory = base_dir / "modules"

    modules = [f.name for f in modules_directory.glob("*.py")]
    if not modules:
        print("No modules found in the directory.")
        exit(1)

    modules.sort()

    for i, file in enumerate(modules, start=1):
        print(f" {i}. {file}")

    selections: list[int]
    try:
        print("Modules to run (space-separated): ")
        input_str = input("> ")

        if input_str == "":
            selections = [x for x in range(len(modules))]
            info("Running all modules")
        else:
            selections = [
                int(x.strip())
                for x in input_str.split(" ")
                if 1 <= int(x.strip()) <= len(modules)
            ]
    except ValueError:
        print("Invalid input. Please enter valid numbers.")
        exit(1)

    modules_to_run = [modules[i - 1] for i in selections]
    for module in modules_to_run:
        info(f"Running {modules_directory}/{module}")
        _ = run_path(f"{modules_directory}/{module}")


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print()
        error("Mystart was cancelled by the user")
