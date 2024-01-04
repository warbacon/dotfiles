status is-interactive
or return

set -gx EDITOR nvim
set -gx VISUAL nvim

if command -q eza
    abbr -a ls eza --icons --group-directories-first
    abbr -a la eza --icons --group-directories-first -a
    abbr -a lla eza --icons --group-directories-first -la --git
    abbr -a lt eza --icons -T
end

command -q fastfetch
abbr -a ffetch fastfetch

test $TERM = "xterm-kitty"
and abbr -a icat kitten icat

bind \eg "go_dir $HOME/Git"
bind \ec "go_dir $HOME/.config"

function prompt_hook --on-event fish_prompt
    if test -z $add_newline
        set -g add_newline true
    else
        printf "\n"
    end

    if test $PWD = $HOME/Git
        abbr -a ll eza --icons --group-directories-first -l --git --git-repos
    else
        abbr -a ll eza --icons --group-directories-first -l --git
    end
end

if command -q trash
    alias rm="trash"
    test -f $__fish_config_dir/completions/rm.fish
    or touch $__fish_config_dir/completions/rm.fish
else
    test -f $__fish_config_dir/completions/rm.fish
    and rm $__fish_config_dir/completions/rm.fish
end

if command -q nvim; and test $TERM != "xterm-kitty"; or string match --quiet "no-cursor" $KITTY_SHELL_INTEGRATION
    function nvim
        eval (command -s nvim) $argv
        printf "\e[0 q"
    end
end

fish_add_path -P "$HOME/.local/bin"

starship init fish --print-full-init | source

test -f "/opt/miniconda3/etc/fish/conf.d/conda.fish"
and source "/opt/miniconda3/etc/fish/conf.d/conda.fish"

