#!/bin/sh
set -e

# echo "cvrez vpn"
# git clone https://aur.archlinux.org/openvpn3.git $HOME/apps
# pushd $HOME/apps/opencvpn3
# makepgk -si 
# popd
# get openvpn profile from pcrequired
# copy i to ~/openvpn
# run ,vpn.sh connect ujv

echo "install from list"

sudo pacman --noconfirm -S - < ../assets/packages.list

echo "setup pyenv"
# assuming it's installev via arch pacman
pyenv install -s 3.11.2
pyenv global 3.11.2
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
which pip
pip install virtualenv

echo "posh git"
wget -O $HOME/apps/dotfiles/scripts/posh_git.sh  https://raw.githubusercontent.com/lyze/posh-git-sh/master/git-prompt.sh

echo "keyboard"
#  this sourcee: https://www.abclinuxu.cz/blog/origami/2006/12/21/162644

sudo cp ~/apps/dotfiles/assets/vok /usr/share/X11/xkb/symbols
sudo sed -i "s/! layout/! layout\n  vok             vogo's CZECH programming keyboard/" /usr/share/X11/xkb/rules/xorg.lst


echo "power management"

echo "HandleLidSwitch=ignore" |sudo tee -a  /etc/systemd/logind.conf > /dev/null
echo "IdleAction=lock" |sudo tee -a  /etc/systemd/logind.conf > /dev/null
echo "IdleActionSec=30min" |sudo tee -a  /etc/systemd/logind.conf > /dev/null


echo "i3"
rm -f ~/.config/i3/config
ln -s ~/apps/dotfiles/home/.config/i3/config ~/.config/i3/config

rm -rf ~/.config/i3status
mkdir -p ~/.config/i3status
ln -s ~/apps/dotfiles/home/.config/i3status/config ~/.config/i3status/config

echo "rofi"
rm -f ~/.config/rofi/config.rasi
mkdir -p ~/.config/rofi
ln -s ~/apps/dotifles/home/.config/rofi/config.rasi ~/.config/rofi/config.rasi

echo "kitty"

ln -s ~/apps/dotfiles/home/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf

echo "vim"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

rm -f ~/.vimrc
ln -s ~/apps/dotfiles/home/.vimrc ~/.vimrc

vim +'PlugInstall --sync' +qa

echo "ssh"
echo " you have to run this manually "
echo "sign in to dbcli and get dbs"
#./setup_ssh.sh

ln -s ~/apps/dotfiles/home/.ssh/config ~/.ssh/config

echo "keepass"
eval ./setup_keepass.sh


echo "fzf"

rm -rf ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings  --completion --no-update-rc

echo "qutebrowser"

./setup_qutebrowser.arch.sh
rm -f ~/.config/qutebrowser/config.py
mkdir -p ~/.config/qutebrowser
ln -s ~/apps/dotfiles/home/.config/qutebrowser/config.py ~/.config/qutebrowser/config.py 

echo "ranger"
mkdir -p ~/.config/ranger
ln -s ~/apps/dotfiles/home/.config/ranger/rc.conf ~/.config/ranger/rc.conf

echo "fs"

mkdir -p downloads
rm -rf Downloads
rm -rf Desktop/
rm -rf Documents/
rm -rf Music/
rm -rf Public/
rm -rf Templates/
rm -rf Videos/

# TODO -no-rc param
echo ".bashrc & .profile"

if [ -z "${NO_RC}" ]; then
	echo "source ~/apps/dotfiles/home/.mybashrc" >> ~/.bashrc
	echo "source ~/apps/dotfiles/home/.myprofile" >> ~/.profile
fi


