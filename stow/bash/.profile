#!/bin/bash

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

setxkbmap -layout vok -variant basic

export PATH="$PATH:$HOME/apps/dotfiles/scripts:/$HOME/apps/dotfiles/assets"

