# UTILITIES -------------------------------------------------------------------
# Detect if running in a real Linux TTY
set -g IS_LINUX_TTY (if test "$TERM" = "linux"; echo true; else; echo false; end)

# For __eza_pwd_hook
if not set -q GIT_REPOS_DIR
    printf '%s$GIT_REPOS_DIR is not set%s\n' (set_color --bold yellow) (set_color reset)
end

# Report current directory to Windows Terminal via OSC7
if set -q WT_SESSION
    function __osc7 --on-variable PWD
        printf "\e]9;9;\"%s\"\e\\" "$PWD"
    end
end
# -----------------------------------------------------------------------------

# FISH SETTINGS ---------------------------------------------------------------
set fish_greeting # Disable fish_greeting
# -----------------------------------------------------------------------------

# ABBREVIATIONS ---------------------------------------------------------------
abbr_if_exists ff fastfetch
abbr_if_exists lg lazygit
abbr_if_exists rt trash

if command -q eza; and test "$IS_LINUX_TTY" != true
    abbr --add -- ls 'eza --icons --group-directories-first'
    abbr --add -- la 'eza --icons --group-directories-first -a'
    abbr --add -- lla 'eza --icons --group-directories-first -la --git'
    abbr --add -- lt 'eza --icons --group-directories-first -T'

    function __update_ll_abbr
        if test "$PWD" = "$GIT_REPOS_DIR"
            abbr --add -- ll 'eza --icons --group-directories-first -l --git-repos'
        else
            abbr --add -- ll 'eza --icons --group-directories-first -l --git'
        end
    end

    __update_ll_abbr

    if test -d "$GIT_REPOS_DIR"
        function __eza_pwd_hook --on-variable PWD
            __update_ll_abbr
        end
    end
end
# -----------------------------------------------------------------------------

# KEYBINDINGS -----------------------------------------------------------------
bind alt-s prepend_sudo
bind alt-c cdf
bind ctrl-r fzf-history
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
        if test -z "$__prompt_add_newline"
            set -g __prompt_add_newline true
        else
            printf "\n"
        end
    end
end
# -----------------------------------------------------------------------------
