export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

export PS1="\[\e[32;1m\]\w> \[\e[0m\]"

  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi

GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS="yes"
GIT_PS1_SHOWDIRTYSTATE="yes"
source ~/.git-prompt.sh

export PROMPT_COMMAND='__git_ps1 "\[\e[32;1m\]\w\[\e[0m\]" "> ";'
