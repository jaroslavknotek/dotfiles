#!/bin/bash
set -e
pushd /tmp
$HOME/apps/dotfiles/assets/dbxcli-linux-amd64 get pass.kdbx
$HOME/apps/dotfiles/assets/dbxcli-linux-amd64 get acafuel.kdbx

mkdir -p ~/keepass-db
mv *.kdbx ~/keepass-db
popd

