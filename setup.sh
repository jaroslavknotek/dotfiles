#!/bin/bash
#WIP

# assuming git
mkdir ~/apps
cd ~/apps
# git clone onepass_cli
# add bash alias:
echo 'alias getpass="python3 ~/apps/onepass_cli/cmd_1pass.py get_from_list -p |xsel -ib"' >> ~/.bash_aliases

# assume python is setup
# git clone qutebrowser 
# build it

ln -s dotfiles/.vimrc ~/.vimrc


# assuming rofi is installed 
ln -s dotfiles/.config/rofi/config.rasi ~/.config/rofi/config.rasi

# assuming i3 is installed
ln -s dotfiles/.config/i3/config ~/.config/i3/config

# setup keyboard
##  this sourcee: https://www.abclinuxu.cz/blog/origami/2006/12/21/162644

sudo cp dotfile/src/vok /usr/share/X11/xkb/symbols
sudo sed -i "s/! layout/! layout\n  vok             vogo's CZECH programming keyboard/" /usr/share/X11/xkb/rules/xorg.lst

