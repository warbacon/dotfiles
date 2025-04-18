# Do nothing if isn't interactive
status is-interactive
or return

# FISH SETTINGS ---------------------------------------------------------------
set -g fish_greeting # Disable fish_greeting
set GIT_DIR "$HOME/Git" # Used to show repo status in ll
# -----------------------------------------------------------------------------

# ABBREVIATIONS ---------------------------------------------------------------
abbr -a rm rm -v
abbr -a mv mv -iv
abbr -a cp cp -iv

command -q trash
and abbr -a rt trash
or printf "%sWARNING:%s trash-cli is not installed.\n" \
    (set_color --bold yellow) (set_color normal)
command -q fastfetch
and abbr -a ffetch fastfetch

command -q lazygit
and abbr -a lg lazygit

test "$TERM" = "xterm-kitty"; and command -q ssh
and abbr -a ssh kitten ssh

if test "$TERM" = xterm-kitty; or test "$TERM" = xterm-ghostty -a (command -q kitten)
    abbr -a icat kitten icat
end

set -q WEZTERM_EXECUTABLE
and abbr -a icat wezterm imgcat

if command -q eza
    abbr -a ls eza --icons --group-directories-first
    abbr -a la eza --icons --group-directories-first -a
    abbr -a lla eza --icons --group-directories-first -la --git
    abbr -a lt eza --icons --group-directories-first -T --level 3

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
bind alt-s prepend_sudo
# -----------------------------------------------------------------------------

# APPEARANCE ------------------------------------------------------------------
fish_config theme choose thunder

if command -q starship
    test -d ~/.cache/starship
    or mkdir ~/.cache/starship

    test -f ~/.cache/starship/init.fish
    or starship init fish --print-full-init >~/.cache/starship/init.fish

    source ~/.cache/starship/init.fish
    and function prompt_newline --on-event fish_prompt
        test -z $_add_newline; and set -g _add_newline true; or echo
    end
end
# -----------------------------------------------------------------------------
