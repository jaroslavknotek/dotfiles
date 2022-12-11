
set -e

echo "Install git"
sudo apt-get update
sudo apt-get install git-all
git version.


echo "Install vim"
sudo apt install vim-gtk3

echo "Installing zoxide"
sudo apt install zoxide

echo '*** zoxide init ***'
echo 'eval "$(zoxide init bash)"' >> .bashrc


