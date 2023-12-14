# ZUNDER-ZSH OPTIONS -----------------------------------------------------------
# DISABLE_AUTOSUGGESTIONS=true
# DISABLE_SYNTAX_HIGHLIGHTING=true
# DISABLE_EXA=true

# ZUNDER-PROMPT ----------------------------------------------------------------
ZUNDER_PROMPT_CHAR="%B>%b"

# DISABLE_ZUNDER_PROMPT=true
# PROMPT="[$USERNAME@$HOST %~]%# "
# zinit snippet "$HOME/Git/zunder-prompt/zunder-prompt.plugin.zsh"
# zinit snippet $ZUNDER_ZSH_DIR/prompt.zsh

# OH-MY-POSH -------------------------------------------------------------------
# zinit as"program" from"gh-r" mv"posh* -> oh-my-posh" \
#     atclone"./oh-my-posh init --config $ZUNDER_ZSH_DIR/thundership.omp.json zsh > init.zsh \
#         && ./oh-my-posh completion zsh > _oh-my-posh" \
#     atpull"%atclone" src"init.zsh" for \
#     "jandedobbeleer/oh-my-posh"

# STARSHIP ---------------------------------------------------------------------
# zinit as"command" from"gh-r" \
#   atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
#   atpull"%atclone" src"init.zsh" for \
#   starship/starship

# FZF INTEGRATION --------------------------------------------------------------
zinit has"fzf" light-mode for \
  https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh

# MINICONDA3 -------------------------------------------------------------------
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] \
  && source /opt/miniconda3/etc/profile.d/conda.sh
