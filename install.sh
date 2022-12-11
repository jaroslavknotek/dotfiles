#!/bin/bash

set -e

echo "Pre install config"
sudo apt-get check
sudo dpkg --configure -a
sudo dpkg --configure -a
sudo apt -f install --yes
sudo apt-get autoremove --yes
sudo apt update && sudo apt upgrade --yes

echo "Install git"
sudo apt-get install git-all
git version

echo "Install xsel"
sudo apt install --yes xsel

echo "install rofi"
sudo apt install --yes rof

echo "Install vim"
sudo apt install --yes vim-gtk3

echo "Installing zoxide"
sudo apt install --yes zoxide

echo '*** zoxide init ***'
echo 'eval "$(zoxide init bash)"' >> .bashrc

echo "Install jq"
sudo apt install --yes jq
