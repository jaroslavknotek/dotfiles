#!/bin/bash
#WIP

set -e

echo "install requirements"

# ./install.sh

echo "setup 1 pass"

# ./setupssh.sh

echo "setup ssh"

# ./setuppass.sh

echo "setup links"

# ./setuplinks.sh

echo "setup fzf + deps"

# ./setupfzf.sh

echo "setting up connection to itself"


git clone git@github.com:jaroslavknotek/dotfiles.git --config core.sshCommand="ssh -i ~/.ssh/id_rsa" ~/apps/dotfiles

echo 'export PATH="$PATH:~/apps/dotfiles/scripts"' >> ~/.bashrc


echo 'Setup keyboard'
##  this sourcee: https://www.abclinuxu.cz/blog/origami/2006/12/21/162644

sudo cp ~/apps/dotfiles/src/vok /usr/share/X11/xkb/symbols
sudo sed -i "s/! layout/! layout\n  vok             vogo's CZECH programming keyboard/" /usr/share/X11/xkb/rules/xorg.lst

echo "setxkbmap -layout vok -variant basic" >> ~/.bashrc

