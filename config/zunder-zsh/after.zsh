# NEOVIM AS DEFAULT EDITOR -----------------------------------------------------
export EDITOR=nvim
export VISUAL=nvim

# ALIASES ----------------------------------------------------------------------
[[ -n $commands[trash] ]] && alias rm="trash" || echo "trash-cli is not installed."
[[ $TERM == "xterm-kitty" ]] && alias icat="kitten icat"
[[ -n $commands[lazygit] ]] && alias lg="lazygit"

# GO_REPO ----------------------------------------------------------------------
GIT_REPOS_DIR="$HOME/Git"

function go_repo() {
  dir="$(eza -D "$GIT_REPOS_DIR" | fzf)"

  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi

  zle push-line
  BUFFER="cd $GIT_REPOS_DIR/$dir"
  zle accept-line
}

zle -N go_repo
bindkey -e "^[g" go_repo

# GO_CONFIG --------------------------------------------------------------------
CONFIG_DIR="$HOME/.config"

function go_config() {
  dir="$(eza -D "$CONFIG_DIR" | fzf)"

  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi

  zle push-line
  BUFFER="cd $CONFIG_DIR/$dir"
  zle accept-line
}

zle -N go_config
bindkey -e "^[c" go_config

# START TMUX -------------------------------------------------------------------
# if [[ -z ${TMUX+X}${ZSH_SCRIPT+X}${ZSH_EXECUTION_STRING+X} ]]; then
#   exec tmux
# fi
