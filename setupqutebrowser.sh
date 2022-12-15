#!/bin/bash

set -e

echo "Setup ssl"
cd /tmp
wget http://cz.archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb
sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb
rm libssl1.1_1.1.1f-1ubuntu2.16_amd64.deb

echo "Setup repo"
git clone https://github.com/qutebrowser/qutebrowser.git /tmp/qutebrowser-qt6
cd /tmp/qutebrowser-qt6
git checkout qt6-v2

sudo mv /tmp/qutebrowser-qt6/ /usr/local/src/qutebrowser

echo "Install"

cd /usr/local/src/qutebrowser
python scripts/mkvenv.py --venv-dir .venv-qt6 --pyqt-version 6.3


echo "#!/bin/bash" > qutebrowser-bin
echo '/usr/local/src/qutebrowser/.venv-qt6/bin/python3.10 -m qutebrowser "$@"' >> qutebrowser-bin
chmod +x qutebrowser-bin

sudo mv qutebrowser-bin /usr/local/bin/qutebrowser

echo 'linking config'
rm -f ~/.config/qutebrowser/config.py
ln -s ~/apps/dotfiles/.config/qutebrowser/config.py ~/.config/qutebrowser/config.py

echo "add pdf js"
/usr/local/src/qutebrowser/.venv-qt6/bin/python scripts/dev/update_3rdparty.py

echo "add qutebrowser profile"
git clone https://github.com/jtyers/qutebrowser-profile.git /tmp/qutebrowser-profile
sudo mv /tmp/qutebrowser-profile/ /usr/local/src/qutebrowser-profile

echo '#!/bin/bash' > /tmp/qutebrowser-profile-bin
echo '/usr/local/src/qutebrowser-profile/qutebrowser-profile' >> /tmp/qutebrowser-profile-bin
chmod +x /tmp/qutebrowser-profile-bin
sudo mv /tmp/qutebrowser-profile-bin /usr/local/bin/qutebrowser-profile

