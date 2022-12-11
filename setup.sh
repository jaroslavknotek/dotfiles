#!/bin/bash
#WIP

set -e

echo "install requirements"

# ./install.sh

echo "setup 1 pass"

# ./setupssh.sh

echo "setup ssh"

# ./setuppass.sh

echo "setting up connection to itself"

git clone git@github.com:jaroslavknotek/dotfiles.git --config core.sshCommand="ssh -i ~/.ssh/id_rsa" ~/apps/dotfiles




# add bash alias:
# echo 'alias getpass="python3 ~/apps/onepass_cli/cmd_1pass.py get_from_list -p |xsel -ib"' >> ~/.bash_aliases

# assume python is setup
# git clone qutebrowser 
# build it

# ln -s dotfiles/.vimrc ~/.vimrc


# assuming rofi is installed 
# ln -s dotfiles/.config/rofi/config.rasi ~/.config/rofi/config.rasi

# assuming i3 is installed
# ln -s dotfiles/.config/i3/config ~/.config/i3/config

# setup keyboard
##  this sourcee: https://www.abclinuxu.cz/blog/origami/2006/12/21/162644

# sudo cp dotfile/src/vok /usr/share/X11/xkb/symbols
# sudo sed -i "s/! layout/! layout\n  vok             vogo's CZECH programming keyboard/" /usr/share/X11/xkb/rules/xorg.lst

