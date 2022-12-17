#!/bin/bash

set -e


echo "Install one pass cli"
# https://developer.1password.com/docs/cli/get-started/#install

curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
 sudo gpg --yes --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" |
 sudo tee /etc/apt/sources.list.d/1password.list

sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | \
 sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
 sudo gpg --yes --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

sudo apt update && sudo apt install 1password-cli
op --version

op --version

echo "S $IS_SIGNED "
if ! (op account list | grep knotekjaroslav@email.cz)
then	
  echo "setup account - requires interaction"
  op account add --address my.1password.com --email knotekjaroslav@email.cz
fi

echo "1pass Setup finished"
