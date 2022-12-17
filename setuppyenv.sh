#!/bin/bash

set -e

rm -rf ~/.pyenv
curl https://pyenv.run | bash

sudo apt install --yes libedit-dev
sudo apt install --yes zlib1g zlib1g-dev libssl-dev libbz2-dev libsqlite3-dev

~/.pyenv/bin/pyenv install 3.10.9
~/.pyenv/bin/pyenv global 3.10.9
