fish_add_path -mP "$HOME/.local/bin"

# Neovim as editor and manpager
if command -q nvim
    set -x EDITOR nvim
    set -x VISUAL nvim
    set -x MANPAGER 'nvim +Man!'
end
