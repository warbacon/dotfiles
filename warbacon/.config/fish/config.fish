# =============================================================================
# UTILITIES
# =============================================================================

# Detect if running in a real Linux TTY
set -g IS_LINUX_TTY (test "$XDG_SESSION_TYPE" = "tty"; and echo true; or echo false)

# Validate GIT_REPOS_DIR for eza integration
if not set -q GIT_REPOS_DIR
    printf '%s$GIT_REPOS_DIR is not set%s\n' (set_color --bold yellow) (set_color normal)
end

# Report current directory to Windows Terminal via OSC7
if set -q WT_SESSION
    function __osc7 --on-variable PWD
        printf "\e]9;9;\"%s\"\e\\" "$PWD"
    end
end

# =============================================================================
# FISH SETTINGS
# =============================================================================

set fish_greeting # Disable greeting

# =============================================================================
# ABBREVIATIONS
# =============================================================================

abbr --add cp 'cp -vi'
abbr --add mv 'mv -vi'
abbr --add rm 'rm -v'

abbr_if_exists ff fastfetch
abbr_if_exists lg lazygit
abbr_if_exists rt trash

# Eza integration (only outside TTY)
if command -q eza; and test "$IS_LINUX_TTY" = false
    abbr --add ls 'eza --icons --group-directories-first'
    abbr --add la 'eza --icons --group-directories-first -a'
    abbr --add lla 'eza --icons --group-directories-first -la --git'
    abbr --add lt 'eza --icons --group-directories-first -T'

    function __update_ll_abbr
        if set -q GIT_REPOS_DIR; and test "$PWD" = "$GIT_REPOS_DIR"
            abbr --add ll 'eza --icons --group-directories-first -l --git-repos'
        else
            abbr --add ll 'eza --icons --group-directories-first -l --git'
        end
    end

    __update_ll_abbr

    # Only set up PWD hook if GIT_REPOS_DIR exists
    if set -q GIT_REPOS_DIR; and test -d "$GIT_REPOS_DIR"
        function __eza_pwd_hook --on-variable PWD
            __update_ll_abbr
        end
    end
end

# =============================================================================
# KEYBINDINGS
# =============================================================================

bind alt-s prepend_sudo
bind alt-c cdf
bind ctrl-r fzf_history

# =============================================================================
# APPEARANCE
# =============================================================================

fish_config theme choose thunder

# Starship prompt (only outside TTY)
if command -q starship; and test "$IS_LINUX_TTY" = false
    set -l starship_cache ~/.cache/starship/init.fish

    # Ensure cache directory exists
    mkdir -p (dirname $starship_cache)

    # Generate or update cached init file
    if not test -f $starship_cache
        starship init fish --print-full-init >$starship_cache
    end

    source $starship_cache

    function prompt_newline --on-event fish_prompt --description "Add newline between prompts"
        if set -q __prompt_add_newline
            printf "\n"
        else
            set -g __prompt_add_newline true
        end
    end
end
