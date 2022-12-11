#!/bin/bash

set -e

echo "Setup AG"

sudo apt-get install --yes silversearcher-ag

echo "setup bat"
sudo apt install --yes bat
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

echo "Setup fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings  --completion  --update-rc

echo "Make changes is .bashrc"

echo "# enable fzf auto completion" >> ~/.bashrc
echo "[ -f ~/.fzf.bash ] && source ~/.fzf.bash" >> ~/.bashrc
echo "# add previews to search invoked with ctrl t" >> ~/.bashrc
echo "export FZF_CTRL_T_OPTS=\"--height 50% --preview 'bat --color=always --style=numbers --line-range=:500 {}' --bind 'ctrl-y:execute-silent(echo {} | xsel -ib)'\"" >> ~/.bashrc

