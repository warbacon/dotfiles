setopt prompt_subst

autoload -Uz add-zsh-hook

function check_first_prompt() {
  if [[ $FIRST_PROMPT == false ]]; then
    printf "\n"
  else
    FIRST_PROMPT=false
  fi
}

add-zsh-hook precmd check_first_prompt

function update_git_prompt() {
  GIT_PROMPT=''
  GIT_PROMPT_LEN=0

  [[ -z $commands[git] ]] && return

  if  [ -d .git ] || git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    local git_branch="$(git branch --show-current)"
    [[ -n "$git_branch" ]] && GIT_PROMPT="on %5F%B$git_branch%b%f"
  fi
}

add-zsh-hook precmd update_git_prompt

PROMPT="%6F%B%~%f%b"
PROMPT+=' ${GIT_PROMPT}'
PROMPT+=$'\n'
PROMPT+='%F{%(?.2.1)}❯%f '
