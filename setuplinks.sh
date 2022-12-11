#!/bin/bash

set -e

echo "Linking vim config"
rm -f ~/.vimrc
ln -s ~/apps/dotfiles/.vimrc ~/.vimrc

echo "Linking rofi config"
rm -f ~/.config/rofi/config.rasi
mkdir -p ~/.config/rofi
ln -s ~/apps/dotifles/.config/rofi/config.rasi ~/.config/rofi/config.rasi

echo "Linking i3 config"
rm -f ~/.config/i3/config
ln -s ~/apps/dotfiles/.config/i3/config ~/.config/i3/config

