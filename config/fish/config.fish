set -gx EDITOR nvim
set -gx VISUAL nvim

status is-interactive
or return

command -q fastfetch
and abbr -a ffetch fastfetch

command -q lazygit
and abbr -a lg lazygit

command -q trash
and abbr -a rm trash
or echo "WARNING: trash-cli is not installed."

test $TERM = "xterm-kitty"
and abbr -a icat kitten icat

if command -q eza
    abbr -a ls eza --icons --group-directories-first
    abbr -a la eza --icons --group-directories-first -a
    abbr -a lla eza --icons --group-directories-first -la --git
    abbr -a lt eza --icons -T
end

function prompt_hook --on-event fish_prompt
    test -z $add_newline; and set -g add_newline true; or printf "\n"

    test $PWD = $HOME/Git
    and abbr -a ll eza --icons --group-directories-first -l --git --git-repos
    or abbr -a ll eza --icons --group-directories-first -l --git
end

bind \eg "go_dir $HOME/Git"
bind \ec "go_dir $HOME/.config"

fish_add_path -P "$HOME/.local/bin"

test -f "/opt/miniconda3/etc/fish/conf.d/conda.fish"
and source "/opt/miniconda3/etc/fish/conf.d/conda.fish"

command -q starship
and starship init fish --print-full-init | source
