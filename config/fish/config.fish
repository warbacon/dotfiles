# ENVIROMENT VARIABLES --------------------------------------------------------
if command -q nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx MANPAGER 'nvim +Man!'
end
# -----------------------------------------------------------------------------

status is-interactive  # Do nothing if isn't interactive
or return

# INTERACTIVE MODE START ======================================================

# VARIABLES -------------------------------------------------------------------
set -g fish_greeting  # Disable fish_greeting
set -gx FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
# -----------------------------------------------------------------------------

# ABBREVIATIONS ---------------------------------------------------------------
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
# -----------------------------------------------------------------------------

# KEYBINDINGS -----------------------------------------------------------------
bind \eg "go_dir $HOME/Git"
bind \ec "go_dir $HOME/.config"
bind \es prepend_sudo
# -----------------------------------------------------------------------------

# MODIFY $PATH ----------------------------------------------------------------
fish_add_path -P "$HOME/.local/bin"

test -f "/opt/miniconda3/etc/fish/conf.d/conda.fish"
and source "/opt/miniconda3/etc/fish/conf.d/conda.fish"
# -----------------------------------------------------------------------------

# PROMPT ----------------------------------------------------------------------
function prompt_hook --on-event fish_prompt
    test -z $add_newline; and set -g add_newline true; or printf "\n"

    test $PWD = $HOME/Git
    and abbr -a ll eza --icons --group-directories-first -l --git --git-repos
    or abbr -a ll eza --icons --group-directories-first -l --git
end

command -q starship
and starship init fish --print-full-init | source
# -----------------------------------------------------------------------------
