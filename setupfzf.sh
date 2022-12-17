#!/bin/bash

set -e

echo "Setup AG"

sudo apt-get install --yes silversearcher-ag

echo "setup bat"
sudo apt install --yes bat
mkdir -p ~/.local/bin

ln -f -s /usr/bin/batcat ~/.local/bin/bat


echo "Setup fzf"

rm -rf ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings  --completion --no-update-rc

echo "Make changes is .bashrc"


