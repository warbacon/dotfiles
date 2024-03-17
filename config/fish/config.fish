# Do nothing if isn't interactive
status is-interactive
or return

# VARIABLES -------------------------------------------------------------------
fish_add_path -P "$HOME/.local/bin"

# Disable fish_greeting
set -g fish_greeting

# Nvim as manpager
if command -q nvim
    set -x EDITOR nvim
    set -x VISUAL nvim
    set -x MANPAGER 'nvim +Man!'
end

# Catppuccin Mocha in fzf
set -x FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--pointer '->'"
# -----------------------------------------------------------------------------

# ABBREVIATIONS ---------------------------------------------------------------
command -q fastfetch
and abbr -a ffetch fastfetch

command -q lazygit
and abbr -a lg lazygit

command -q trash
and abbr -a rm trash
or printf "%sWARNING:%s trash-cli is not installed.\n" \
    (set_color --bold yellow) (set_color normal)

test $TERM = xterm-kitty
and abbr -a icat kitten icat

set -q WEZTERM_EXECUTABLE
and abbr -a icat wezterm imgcat

if command -q eza
    abbr -a ls eza --icons --group-directories-first
    abbr -a la eza --icons --group-directories-first -a
    abbr -a lla eza --icons --group-directories-first -la --git
    abbr -a lt eza --icons -T
end
# -----------------------------------------------------------------------------

# KEYBINDINGS -----------------------------------------------------------------
if command -q fzf
    bind \eg "go_dir $HOME/Git"
    bind \ec "go_dir $HOME/.config"
end

bind \es prepend_sudo
bind \e\[3\;5~ kill-word
# -----------------------------------------------------------------------------

# PROMPT ----------------------------------------------------------------------
function prompt_hook --on-event fish_prompt
    test -z $add_newline; and set -g add_newline true; or printf "\n"

    if command -q eza
        test $PWD = $HOME/Git
        and abbr -a ll eza --icons --group-directories-first -l --git --git-repos
        or abbr -a ll eza --icons --group-directories-first -l --git
    end
end

command -q starship
and starship init fish --print-full-init | source
