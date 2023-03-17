#!/bin/bash

set -e

echo "Setup repo"
rm -rf /tmp/qutebrowser-qt6
git clone https://github.com/qutebrowser/qutebrowser.git /tmp/qutebrowser-qt6
cd /tmp/qutebrowser-qt6
git checkout qt6-v2

sudo rm -rf /usr/local/src/qutebrowser
sudo mkdir -p /usr/local/src/qutebrowser
sudo mv /tmp/qutebrowser-qt6/* /usr/local/src/qutebrowser/

echo "Install"

cd /usr/local/src/qutebrowser
sudo /home/jry/.pyenv/shims/python3.11 scripts/mkvenv.py --venv-dir .venv-qt6 --pyqt-version 6.3

echo "#!/bin/bash" > /tmp/qutebrowser-bin
echo '/usr/local/src/qutebrowser/.venv-qt6/bin/python3.11 -m qutebrowser "$@"' >> /tmp/qutebrowser-bin
chmod +x /tmp/qutebrowser-bin

sudo mv /tmp/qutebrowser-bin /usr/local/bin/qutebrowser

echo 'linking config'
rm -f ~/.config/qutebrowser/config.py
mkdir -p ~/.config/qutebrowser
ln -s ~/apps/dotfiles/home/.config/qutebrowser/config.py ~/.config/qutebrowser/config.py

echo "add pdf js"
/usr/local/src/qutebrowser/.venv-qt6/bin/python scripts/dev/update_3rdparty.py

echo "add qutebrowser profile"
rm -rf /tmp/qutebrowser-profile
git clone https://github.com/jtyers/qutebrowser-profile.git /tmp/qutebrowser-profile
sudo rm -rf /usr/local/src/qutebrowser-profile
sudo mv /tmp/qutebrowser-profile/ /usr/local/src/qutebrowser-profile

echo '#!/bin/bash' > /tmp/qutebrowser-profile-bin
echo '/usr/local/src/qutebrowser-profile/qutebrowser-profile' >> /tmp/qutebrowser-profile-bin
chmod +x /tmp/qutebrowser-profile-bin

sudo mv /tmp/qutebrowser-profile-bin /usr/local/bin/qutebrowser-profile

# contains libsmime3.so
sudo pacman --noconfirm -Sy nss


echo "[Desktop Entry]" > /tmp/qb.desktop
echo "Type=Application" >> /tmp/qb.desktop 
echo "Name=qutebrowser" >> /tmp/qb.desktop 
echo "Exec=qutebrowser" >> /tmp/qb.desktop 

sudo mv /tmp/qb.desktop /usr/local/src/qutebrowser/org.qutebrowser.qutebrowser.desktop
xdg-mime default /usr/local/src/qutebrowser/org.qutebrowser.qutebrowser.desktop x-sheme-handler/https
xdg-mime default /usr/local/src/qutebrowser/org.qutebrowser.qutebrowser.desktop x-sheme-handler/http


