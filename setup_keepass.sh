#!/bin/bash

set -e

KEEPASS_PATH=~/apps/keepassxc_q_cli
git clone git@github.com:jaroslavknotek/keepassxc_q_cli.git --config core.sshCommand="ssh -i ~/.ssh/id_rsa" $KEEPASS_PATH 

cd $KEEPASS_PATH
git config user.email knotekjaroslav@email.cz
git config user.name "Jaroslav Knotek"

cd -

