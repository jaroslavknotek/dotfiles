#!/bin/bash
set -e

echo "install requirements"

./install.sh

echo "setup 1 pass"
./setuppass.sh

SESSION=(echo -n $password | op signin --raw --account my.1password.com)

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
mkdir .config/dunst
cp /etc/xdg/dunst/dunstrc ~/.config/dunst/
sed -i "s/history = ctrl+grave/#     history = ctrl+grave/" ~/.config/dunst/dunstrc 

echo "setting up connection to itself"

git clone git@github.com:jaroslavknotek/dotfiles.git --config core.sshCommand="ssh -i ~/.ssh/id_rsa" ~/apps/dotfiles

echo 'export PATH="$PATH:~/apps/dotfiles/scripts"' >> ~/.bashrc


echo 'Setup keyboard'
##  this sourcee: https://www.abclinuxu.cz/blog/origami/2006/12/21/162644

sudo cp ~/apps/dotfiles/src/vok /usr/share/X11/xkb/symbols
sudo sed -i "s/! layout/! layout\n  vok             vogo's CZECH programming keyboard/" /usr/share/X11/xkb/rules/xorg.lst

echo "setxkbmap -layout vok -variant basic" >> ~/.bashrc


echo "Installing cvr vpn"

./setup_openvpn3.sh

op document get ha2euu4iqkbzrlenleq3s6evzy --output=cvr-profile.ovpn --session $SESSION
mkdir -p .openvpn
mv cvr-profile.ovpn .openvpn/

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

