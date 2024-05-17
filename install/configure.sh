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

echo "install paru"

git clone https://aur.archlinux.org/paru.git ~/paru
pushd ~/paru
makepkg -is
popd

echo "install from aur"

mkdir ~/apps

while IFS= read -r line; do
    echo "Text read from file: $line"
    
    pushd tmp
    rm -rf tmp-repo
    mkdir tmp-repo
    pushd tmp-repo
    git clone $line
    mv $(ls -1) ~/apps
    popd
    rmdir tmp-repo
    popd

done < ../assets/aur_repos


echo "STOW config"
stow -S flameshot bash autorandr nvim i3 kitty qutebrowser rofi ranger ssh -d ~/apps/dotfiles/stow/ -v -t ~/

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


echo "vim"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


vim +'PlugInstall --sync' +qa

echo "ssh"
echo " you have to run this manually "
echo "sign in to dbcli and get dbs"
#./setup_ssh.sh


echo "keepass"
eval ./setup_keepass.sh

echo "fzf"

rm -rf ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings  --completion --no-update-rc

echo "qutebrowser"

./setup_qutebrowser.arch.sh


echo "fs"

mkdir -p downloads
rm -rf Downloads
rm -rf Desktop/
rm -rf Documents/
rm -rf Music/
rm -rf Public/
rm -rf Templates/
rm -rf Videos/

