#!/bin/bash


GIT_SSH_PUB_ID=tdlesd4qkn6m7blzxfb4yh3pga
GIT_SSH_ID=qbza5tdouixh27hjcelplz7llq

echo "Getting ssh from 1pass"
echo "  using jq $(jq --version)"

read -s -p "get 1pass password" password
echo ""

SESSION=$(echo -n $password | op signin --raw --account my.1password.com)

echo "1Pass session received"

mkdir -p  ~/.ssh

echo "reading pubkey"
op item get $GIT_SSH_PUB_ID --session "$SESSION" --fields label=notesPlain --format=json | jq -r '.value' > ~/.ssh/id_rsa.pub

echo "reading privatekey"
op item get $GIT_SSH_ID --session "$SESSION" --fields label=notesPlain --format=json | jq -r '.value' > ~/.ssh/id_rsa

chmod 400 ~/.ssh/id_rsa


echo -e "\033[0;32mDONE\033[0;30m"


