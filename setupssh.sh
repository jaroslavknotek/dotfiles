#!/bin/bash


GIT_SSH_PUB_ID=tdlesd4qkn6m7blzxfb4yh3pga
GIT_SSH_ID=qbza5tdouixh27hjcelplz7llq

echo "Getting ssh from 1pass"
echo "  using jq $(jq --version)"

SESSION=$1

echo "1Pass session received"

mkdir -p  ~/.ssh

echo "reading pubkey"
op item get $GIT_SSH_PUB_ID --session "$SESSION" --fields label=notesPlain --format=json | jq -r '.value' > ~/.ssh/id_rsa.pub

echo "reading privatekey"
rm -f ~/.ssh/id_rsa
op item get $GIT_SSH_ID --session "$SESSION" --fields label=notesPlain --format=json | jq -r '.value' > ~/.ssh/id_rsa

chmod 400 ~/.ssh/id_rsa

echo "DONE"
