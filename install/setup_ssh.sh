#!/bin/bash

set -e

DB_PATH=$HOME/apps/dotfiles/assets/pcrequired.kdbx
SSH_ROOT=~/.ssh

read -p "Type DB password: " -s PASS
echo ""
echo "Setting up SSH"

mkdir -p  $SSH_ROOT

echo "$(keepassxc-cli show -q -s -a Notes $DB_PATH "Git SSH Priv" < <(echo "$PASS"))" > /tmp/id_rsa
sudo mv /tmp/id_rsa $SSH_ROOT/id_rsa 
echo "$(keepassxc-cli show -q -s -a Notes $DB_PATH "Git SSH Pub" < <(echo "$PASS"))" > /tmp/id_rsa
sudo mv /tmp/id_rsa $SSH_ROOT/id_rsa.pub 

chmod 400 ~/.ssh/id_rsa


