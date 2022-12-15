#!/bin/bash

set -e

sudo dpkg --configure -a
sudo apt -f install --yes
sudo apt-get autoremove --yes
sudo apt update && sudo apt upgrade --yes

echo "install i3"
sudo apt install --yes i3

echo "Linking i3 config"
rm -f ~/.config/i3/config
ln -s ~/apps/dotfiles/.config/i3/config ~/.config/i3/config

echo "Install git"
sudo apt-get install --yes git-all
git version

echo "Install xsel"
sudo apt install --yes xsel

echo "install rofi"
sudo apt install --yes rof

echo "Linking rofi config"
rm -f ~/.config/rofi/config.rasi
mkdir -p ~/.config/rofi
ln -s ~/apps/dotifles/.config/rofi/config.rasi ~/.config/rofi/config.rasi


echo "Install vim + vim-plug"
sudo apt install --yes vim-gtk3
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "export EDITOR=vim" >> .bashrc

echo "Linking vim config"
rm -f ~/.vimrc
ln -s ~/apps/dotfiles/.vimrc ~/.vimrc



echo "Installing zoxide"
sudo apt install --yes zoxide

echo '*** zoxide init ***'
echo 'eval "$(zoxide init bash)"' >> .bashrc

echo "Install jq"
sudo apt install --yes jq

echo "Install flameshot"
sudo apt install --yes flameshot

echo "Install build-essentials"
sudo apt install --yes build-essential
