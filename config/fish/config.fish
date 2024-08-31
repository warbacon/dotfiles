# ENV VARIABLES ---------------------------------------------------------------
fish_add_path -P "$HOME/.local/bin"

# Neovim as editor and manpager
if command -q nvim
    set -x EDITOR nvim
    set -x VISUAL nvim
    set -x MANPAGER 'nvim +Man!'
end
# -----------------------------------------------------------------------------

# Do nothing if isn't interactive
status is-interactive
or return

# FISH SETTINGS ---------------------------------------------------------------
# Disable fish_greeting
set -g fish_greeting

set GIT_DIR "$HOME/Git"
# -----------------------------------------------------------------------------

# ABBREVIATIONS ---------------------------------------------------------------
abbr rm rm -iv
abbr mv mv -iv
abbr cp cp -iv

command -q trash
and abbr -a rt trash
or printf "%sWARNING:%s trash-cli is not installed.\n" \
    (set_color --bold yellow) (set_color normal)

command -q fastfetch
and abbr -a ffetch fastfetch

command -q lazygit
and abbr -a lg lazygit

test $TERM = xterm-kitty
and abbr -a icat kitten icat

if command -q eza
    abbr -a ls eza --icons --group-directories-first
    abbr -a la eza --icons --group-directories-first -a
    abbr -a lla eza --icons --group-directories-first -la --git
    abbr -a lt eza --icons -T --level 3

    if test -d $GIT_DIR
        function eza_hook --on-event fish_prompt
            test $PWD = $GIT_DIR
            and abbr -a ll eza --icons --group-directories-first -l --git-repos
            or abbr -a ll eza --icons --group-directories-first -l --git
        end
    end
end
# -----------------------------------------------------------------------------

# KEYBINDINGS -----------------------------------------------------------------
bind \es prepend_sudo
bind \e\[3\;5~ kill-word
# -----------------------------------------------------------------------------

# PROMPT ----------------------------------------------------------------------
function prompt_newline --on-event fish_prompt
    test -z $add_newline; and set -g add_newline true; or printf "\n"
end

command -q starship
and starship init fish --print-full-init | source
