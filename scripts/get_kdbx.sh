#!/bin/bash

cd ~/apps/dotfiles/src
dbxcli-linux-amd64 get pass.kdbx
dbxcli-linux-amd64 get acafuel.kdbx

mkdir ~/keepass-db
mv *.kdbx keepass-db
