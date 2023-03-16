

# echo "cvrez vpn"
# git clone https://aur.archlinux.org/openvpn3.git $HOME/apps
# pushd $HOME/apps/opencvpn3
# makepgk -si 
# popd
# get openvpn profile from pcrequired
# copy i to ~/openvpn
# run ,vpn.sh connect ujv

echo "install from list"

pacman -S - < ../assets/packages.list

echo "posh git"
wget -O $HOME/apps/posh_git.sh  https://raw.githubusercontent.com/lyze/posh-git-sh/master/git-prompt.sh

echo "keyboard"
#  this sourcee: https://www.abclinuxu.cz/blog/origami/2006/12/21/162644

sudo cp ~/apps/dotfiles/src/vok /usr/share/X11/xkb/symbols
sudo sed -i "s/! layout/! layout\n  vok             vogo's CZECH programming keyboard/" /usr/share/X11/xkb/rules/xorg.lst


echo "power management"

echo "HandleLidSwitch=ignore" |sudo tee -a  /etc/systemd/logind.conf > /dev/null
echo "IdleAction=lock" |sudo tee -a  /etc/systemd/logind.conf > /dev/null
echo "IdleActionSec=30min" |sudo tee -a  /etc/systemd/logind.conf > /dev/null


echo "i3"
rm -f ~/.config/i3/config
ln -s ~/apps/dotfiles/home/.config/i3/config ~/.config/i3/config

echo "rofi"
rm -f ~/.config/rofi/config.rasi
mkdir -p ~/.config/rofi
ln -s ~/apps/dotifles/home/.config/rofi/config.rasi ~/.config/rofi/config.rasi


echo "vim"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

rm -f ~/.vimrc
ln -s ~/apps/dotfiles/home/.vimrc ~/.vimrc

vim +'PlugInstall --sync' +qa

echo "keepass"
./setup_keepass.sh


echo "ssh"
echo " you have to run this manually "
echo "sign in to dbcli and get dbs"
#./setup_ssh.sh

echo "fzf"

rm -rf ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings  --completion --no-update-rc

echo "qutebrowser"

./setup_qutebrowser.arch.sh
rm -f ~/.config/qutebrowser/config.py
mkdir -p ~/.config/qutebrowser
ln -s ~/apps/dotfiles/home/.config/qutebrowser/config.py ~/.config/qutebrowser/config.py 

echo "[Desktop Entry]" > /tmp/qb.desktop
echo "Type=Application" > /tmp/qb.desktop 
echo "Name=qutebrowser" > /tmp/qb.desktop 
echo "Exec=qutebrowser" > /tmp/qb.desktop 

sudo mv /tmp/qb.desktop org.qutebrowser.qutebrowser.desktop
xdg-settings set default-web-browser org.qutebrowser.qutebrowser.desktop

echo "fs"

mkdir downloads
mv Downloads/* downloads
rmdir Downloads
rmdir Desktop/
rmdir Documents/
rmdir Music/
rmdir Public/
rmdir Templates/
rmdir Videos/

# TODO -no-rc param
# echo ".bashrc & .profile"

# echo "source ~/apps/dotfiles/.mybashrc" >> ~/.bashrc
# echo "source ~/apps/dotfiles/.myprofile" >> ~/.profile

