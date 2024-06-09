# Do nothing if isn't interactive
status is-interactive
or return

# VARIABLES -------------------------------------------------------------------
fish_add_path -P "$HOME/.local/bin"
fish_add_path -P "$HOME/go/bin"

# Disable fish_greeting
set -g fish_greeting

# Memes in errors
# set ENABLE_MEMES true

# Nvim as manpager
if command -q nvim
    set -x EDITOR nvim
    set -x VISUAL nvim
    set -x MANPAGER 'nvim +Man!'
end
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
bind \es prepend_sudo
bind \e\[3\;5~ kill-word
# -----------------------------------------------------------------------------

# PROMPT ----------------------------------------------------------------------
function prompt_hook --on-event fish_prompt
    test -z $add_newline; and set -g add_newline true; or printf "\n"

    if command -q eza
        test $PWD = $HOME/Git
        and abbr -a ll eza --icons --group-directories-first -l --git-repos
        or abbr -a ll eza --icons --group-directories-first -l --git
    end
end

command -q starship
and starship init fish --print-full-init | source
