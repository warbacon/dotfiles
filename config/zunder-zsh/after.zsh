# NEOVIM AS DEFAULT EDITOR -----------------------------------------------------
export EDITOR=nvim
export VISUAL=nvim

# ALIASES ----------------------------------------------------------------------
[[ -n $commands[trash] ]] && alias rm="trash" || echo "trash-cli is not installed."
[[ $TERM == "xterm-kitty" ]] && alias icat="kitten icat"

# NEOVIM CURSOR FIX ------------------------------------------------------------
if [[ -z $KITTY_SHELL_INTEGRATION && -n $commands[nvim] ]]; then
  function nvim() { $commands[nvim] "$@"; printf "\e[0 q" }
fi

# START TMUX -------------------------------------------------------------------
# if [[ -z ${TMUX+X}${ZSH_SCRIPT+X}${ZSH_EXECUTION_STRING+X} ]]; then
#   exec tmux
# fi

# noafetch
