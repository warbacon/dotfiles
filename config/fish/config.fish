# ENVIROMENT VARIABLES --------------------------------------------------------
if command -q nvim
    set -x EDITOR nvim
    set -x VISUAL nvim
    set -x MANPAGER 'nvim +Man!'
end
# -----------------------------------------------------------------------------

status is-interactive # Do nothing if isn't interactive
or return

# INTERACTIVE MODE START ======================================================

# VARIABLES -------------------------------------------------------------------
set -g fish_greeting # Disable fish_greeting
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
or echo "WARNING: trash-cli is not installed."

test $TERM = xterm-kitty
and abbr -a icat kitten icat

set -q $WEZTERM_EXECUTABLE
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
# -----------------------------------------------------------------------------

# MODIFY $PATH ----------------------------------------------------------------
fish_add_path -P "$HOME/.local/bin"
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
# -----------------------------------------------------------------------------
