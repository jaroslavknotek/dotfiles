#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '


alias ll='ls --color=auto -alFh'

eval "$(zoxide init bash)"
export EDITOR=vim


# enable fzf auto completion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# add previews to search invoked with ctrl t
export FZF_CTRL_T_OPTS="--height 50% --preview 'bat --color=always --style=numbers --line-range=:500 {}' --bind 'ctrl-y:execute-silent(echo {} | xsel -ib)'"

export PATH="$PATH:~/apps/dotfiles/scripts"
setxkbmap -layout vok -variant basic


resolve_venv(){
    if [[ -z "${VIRTUAL_ENV}" ]]; then
        echo ""
    else
	    DIRNAME=$(dirname $VIRTUAL_ENV)
	    VENV_NAME=$(basename "$DIRNAME")
	echo "($VENV_NAME) "
    fi
}

# requires posh-git and conda
source $HOME/apps/dotfiles/scripts/posh_git.sh
export PROMPT_COMMAND='__posh_git_ps1 "$(resolve_venv)$CONDA_PROMPT_MODIFIER\\[\[\e[0;32m\]\u@\h \[\e[0;33m\]\w" " \[\e[1;34m\]\$\[\e[0m\] ";'$PROMPT_COMMAND

shopt -s globstar

[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
