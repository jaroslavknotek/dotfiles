#!/bin/bash

set -e

echo "Setup repo"

QUTE_TMPDIR=/tmp/qutebrowser_install
QUTE_VENV=.venv

rm -rf "$QUTE_TMPDIR"
git clone https://github.com/qutebrowser/qutebrowser.git "$QUTE_TMPDIR"
cd "$QUTE_TMPDIR"

sudo rm -rf /usr/local/src/qutebrowser
sudo mkdir -p /usr/local/src/qutebrowser
sudo mv "$QUTE_TMPDIR"/* /usr/local/src/qutebrowser/

echo "Install"

cd /usr/local/src/qutebrowser
sudo /home/jry/.pyenv/shims/python3.10 scripts/mkvenv.py --venv-dir "$QUTE_VENV" --pyqt-version 6.3

echo "#!/bin/bash" > /tmp/qutebrowser-bin

venv_path="/usr/local/src/qutebrowser/$QUTE_VENV"
cmd_res='bin/python3.10 -m qutebrowser "$@"'
echo "${venv_path}/${cmd_res}" >> /tmp/qutebrowser-bin
chmod +x /tmp/qutebrowser-bin

sudo mv /tmp/qutebrowser-bin /usr/local/bin/qutebrowser

echo 'linking config'
rm -f ~/.config/qutebrowser/config.py
mkdir -p ~/.config/qutebrowser
ln -s ~/apps/dotfiles/home/.config/qutebrowser/config.py ~/.config/qutebrowser/config.py

echo "add pdf js"
$venv_path/bin/python scripts/dev/update_3rdparty.py

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


