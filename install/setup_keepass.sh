#!/bin/bash

set -e

KEEPASS_PATH=~/apps/keepassxc_q_cli
rm -rf $KEEPASS_PATH
git clone git@github.com:jaroslavknotek/keepassxc_q_cli.git --config core.sshCommand="ssh -i ~/.ssh/id_rsa" $KEEPASS_PATH 

pushd $KEEPASS_PATH
git checkout feature/support_qutebrowser
git config user.email knotekjaroslav@email.cz
git config user.name "Jaroslav Knotek"


~/.pyenv/shims/python -m virtualenv .venv

$KEEPASS_PATH/.venv/bin/pip install -r $KEEPASS_PATH/requirements.txt

popd
