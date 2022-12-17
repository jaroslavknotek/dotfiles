#!/bin/bash
set -e

sudo dpkg --configure -a
sudo apt -f install --yes
sudo apt-get autoremove --yes
sudo apt update && sudo apt upgrade --yes
sudo apt install curl

echo "Install git"
sudo apt-get install --yes git-all
git version

echo "Install build-essentials"
sudo apt install --yes build-essential

echo "setup 1 pass"
./setuppass.sh

read -p "1pass password: " -s password
SESSION=$(echo -n $password | op signin --raw --account my.1password.com)

echo "setup ssh"
./setupssh.sh $SESSION

echo "setup fzf + deps"
./setupfzf.sh

echo "Setup pyenv"
./setuppyenv.sh

echo "setup systemd stuff"

echo "HandleLidSwitch=ignore" |sudo tee -a  /etc/systemd/logind.conf > /dev/null
echo "IdleAction=lock" |sudo tee -a  /etc/systemd/logind.conf > /dev/null
echo "IdleActionSec=30min" |sudo tee -a  /etc/systemd/logind.conf > /dev/null

echo "disable grave invoking history"
mkdir -p ~/.config/dunst
cp /etc/xdg/dunst/dunstrc ~/.config/dunst/
sed -i "s/history = ctrl+grave/#     history = ctrl+grave/" ~/.config/dunst/dunstrc 

echo "setting up connection to itself"

rm -rf ~/apps/dotfiles
git clone git@github.com:jaroslavknotek/dotfiles.git --config core.sshCommand="ssh -i ~/.ssh/id_rsa" ~/apps/dotfiles
cd ~/apps/dotfiles
git config user.email knotekjaroslav@email.cz
git config user.name "Jaroslav Knotek"


echo 'Setup keyboard'
##  this sourcee: https://www.abclinuxu.cz/blog/origami/2006/12/21/162644

sudo cp ~/apps/dotfiles/src/vok /usr/share/X11/xkb/symbols
sudo sed -i "s/! layout/! layout\n  vok             vogo's CZECH programming keyboard/" /usr/share/X11/xkb/rules/xorg.lst

echo "Installing cvr vpn"

./setup_openvpn3.sh

op document get ha2euu4iqkbzrlenleq3s6evzy --output=cvr-profile.ovpn --session $SESSION
mkdir -p ~/.openvpn
mv cvr-profile.ovpn ~/.openvpn/

openvpn3 config-import --config ~/.openvpn/cvr-profile.ovpn
rm -f openvpn-repo-pkg-key.pub*
sudo snap install remmina
sudo snap connect remmina:audio-record :audio-record
sudo snap connect remmina:avahi-observe :avahi-observe
sudo snap connect remmina:cups-control :cups-control
sudo snap connect remmina:mount-observe :mount-observe
sudo snap connect remmina:password-manager-service :password-manager-service
sudo snap connect remmina:ssh-keys :ssh-keys
sudo snap connect remmina:ssh-public-keys :ssh-public-keys

echo "  Signin using RDP saved in password manager"

echo "Install opennconnect"
sudo apt install --yes openconnect

echo "install i3"
sudo apt install --yes i3

echo "Linking i3 config"
rm -f ~/.config/i3/config
ln -s ~/apps/dotfiles/.config/i3/config ~/.config/i3/config


echo "install rofi"
sudo apt install --yes rofi

echo "Linking rofi config"
rm -f ~/.config/rofi/config.rasi
mkdir -p ~/.config/rofi
ln -s ~/apps/dotifles/.config/rofi/config.rasi ~/.config/rofi/config.rasi


echo "Install vim + vim-plug"
sudo apt install --yes vim-gtk3
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Linking vim config"
rm -f ~/.vimrc
ln -s ~/apps/dotfiles/.vimrc ~/.vimrc

echo "Install xsel"
sudo apt install --yes xsel


echo "Installing zoxide"
sudo apt install --yes zoxide
echo "Install jq"
sudo apt install --yes jq

echo "Install flameshot"
sudo apt install --yes flameshot

echo "Run the following"
echo 'echo "source ~/apps/dotfiles/.mybashrc" >> ~/.bashrc'
echo 'echo "source ~/apps/dotfiles/.myprofile" >> ~/.profile'
