# PATH -------------------------------------------------------------------------
export PATH="$HOME/.local/bin:$PATH"
# ------------------------------------------------------------------------------

[[ $- == *i* ]] || exit

# UTILITIES --------------------------------------------------------------------
command_exists() {
    command -v "$1" >/dev/null
}
# ------------------------------------------------------------------------------

# OPTIONS ----------------------------------------------------------------------
bind -s "set completion-ignore-case on"
shopt -s autocd
shopt -s cdspell
shopt -s histappend
export HISTCONTROL=ignoreboth:erasedups
# ------------------------------------------------------------------------------

# ALIASES ----------------------------------------------------------------------
if command_exists eza && [[ "$TERM" != "linux" ]]; then
    alias ls="eza --icons=auto --group-directories-first"
    alias ll="eza --icons=auto --group-directories-first --git -l"
    alias la="eza --icons=auto --group-directories-first -a"
    alias lla="eza --icons=auto --group-directories-first --git -la"
else
    alias ls="ls --color=auto --group-directories-first"
    alias ll="ll --color=auto --group-directories-first -lh"
    alias la="la --color=auto --group-directories-first -A"
    alias lla="lla --color=auto --group-directories-first -lhA"
fi

alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -v"
alias open="xdg-open"
# ------------------------------------------------------------------------------

# PROMPT -----------------------------------------------------------------------
_add_newline() {
    [[ -z "$_should_add_newline" ]] && _should_add_newline=true || echo
}
PROMPT_COMMAND="_add_newline; $PROMPT_COMMAND"

PS1='\[\e[1m\]\[\e[34m\]\w\[\e[0m\]\$ '

if command_exists starship; then
    [[ -d "$HOME/.cache/starship" ]] || mkdir -p "$HOME/.cache/starship"

    if [[ ! -f "$HOME/.cache/starship/init.sh" ]]; then
        starship init bash --print-full-init >"$HOME/.cache/starship/init.sh"
        starship completions bash >>"$HOME/.cache/starship/init.sh"
    fi

    [[ "$TERM" != "linux" ]] && source "$HOME/.cache/starship/init.sh"
fi
# ------------------------------------------------------------------------------

# KEYBINDS ---------------------------------------------------------------------
fzf-history() {
    local cmd
    cmd=$(
        fc -lnr 1 2>/dev/null \
            | sed 's/^[[:space:]]*//' \
            | fzf --query="$READLINE_LINE" \
                --prompt="History> " \
                --layout=reverse \
                --height=50% \
                --cycle \
                --border \
                --no-sort
    )
    if [[ -n "$cmd" ]]; then
        READLINE_LINE="$cmd"
        READLINE_POINT=${#READLINE_LINE}
    fi
}

bind -x '"\C-r": fzf-history'

cdf() {
    local preview_cmd
    if [[ $COLUMNS -gt 80 ]]; then
        preview_cmd="eza --tree --color=always --level=3 --icons=always {}"
    fi

    local dir
    dir="$(
        fd --type directory -H \
            --exclude .git \
            --exclude node_modules \
            --exclude .cache \
            --exclude .local/share/Trash \
            --exclude .vscode \
            --exclude .npm \
            --exclude .docker \
            --exclude .mozilla \
            --exclude vendor \
            | fzf --height=50% \
                --prompt="Go to> " \
                --scheme=path \
                --layout=reverse \
                --border \
                --cycle \
                --preview="$preview_cmd"
    )"

    if [[ -n "$dir" ]]; then
        READLINE_LINE="cd '$dir'"
        READLINE_POINT=${#READLINE_LINE}
    fi
}

bind -x '"\ec": cdf'
# ------------------------------------------------------------------------------
