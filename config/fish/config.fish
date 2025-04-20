# Do nothing if not interactive
status is-interactive; or return

# DETECTION -------------------------------------------------------------------
# Detect if running in a real Linux TTY
set -g IS_LINUX_TTY (if test "$TERM" = "linux"; echo true; else; echo false; end)
# -----------------------------------------------------------------------------

# FISH SETTINGS ---------------------------------------------------------------
set -g fish_greeting # Disable fish_greeting
set -g GIT_DIR "$HOME/Git" # Used to show repo status in ll
# -----------------------------------------------------------------------------

# ABBREVIATIONS ---------------------------------------------------------------
abbr -a rm rm -v
abbr -a mv mv -iv
abbr -a cp cp -iv

if command -q trash
    abbr -a rt trash
else
    printf "%sWARNING:%s trash-cli is not installed.\n" \
        (set_color --bold yellow) (set_color normal)
end

command -q fastfetch; and abbr -a ff fastfetch
command -q lazygit; and abbr -a lg lazygit

if test "$TERM" = xterm-kitty; and command -q ssh
    abbr -a ssh kitten ssh
end

if test "$TERM" = xterm-kitty -o "$TERM" = xterm-ghostty
    and command -q kitten
    abbr -a icat kitten icat
end

set -q WEZTERM_EXECUTABLE
and abbr -a icat wezterm imgcat

if command -q eza; and test "$IS_LINUX_TTY" != true
    abbr -a ls eza --icons --group-directories-first
    abbr -a la eza --icons --group-directories-first -a
    abbr -a lla eza --icons --group-directories-first -la --git
    abbr -a lt eza --icons --group-directories-first -T --level 3

    if test -d "$GIT_DIR"
        function eza_hook --on-event fish_prompt
            if test "$PWD" = "$GIT_DIR"
                abbr -a ll eza --icons --group-directories-first -l --git-repos
            else
                abbr -a ll eza --icons --group-directories-first -l --git
            end
        end
    end
end
# -----------------------------------------------------------------------------

# KEYBINDINGS -----------------------------------------------------------------
bind alt-s prepend_sudo
# -----------------------------------------------------------------------------

# APPEARANCE ------------------------------------------------------------------
fish_config theme choose thunder

if command -q starship; and test "$IS_LINUX_TTY" != true
    if not test -d ~/.cache/starship
        mkdir -p ~/.cache/starship
    end

    if not test -f ~/.cache/starship/init.fish
        starship init fish --print-full-init >~/.cache/starship/init.fish
    end

    source ~/.cache/starship/init.fish

    function prompt_newline --on-event fish_prompt
        if test -z "$_add_newline"
            set -g _add_newline true
        else
            echo
        end
    end
end
# -----------------------------------------------------------------------------
