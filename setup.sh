#WIP

# assuming git
# assuming username = jry does it have to be so?
mkdir ~/apps
cd apps
# git clone onepass_cli
# add bash alias:
echo 'alias getpass="python3 ~/apps/onepass_cli/cmd_1pass.py get_from_list -p |xsel -ib"' >> ~/.bash_aliases

# assume python is setup
# git clone qutebrowser 
# build it

ln -s /home/jry/apps/dotfiles/.vimrc .vimrc


# assuming rofi is installed 
ln -s /home/jry/apps/dotfiles/.config/rofi/config.rasi /home/jry/.config/rofi/config.rasi

# assuming i3 is installed
ln -s /home/jry/apps/dotfiles/.config/i3/config config

# codium
# clone + build

