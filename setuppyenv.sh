#!/bin/bash

curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
echo 'eval "$(pyenv init -)"' >> ~/.profile

sudo apt install --yes libedit-dev
sudo apt install --yess zlib1g zlib1g-dev libssl-dev libbz2-dev libsqlite3-dev

pyenv install 3.10.9
pyenv global 3.10.9
