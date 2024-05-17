#!/bin/bash

set -euo pipefail

print_help()
{
	echo "This is placeholder for help"
}

NOTES_PATH="/home/jry/documents/notes_vault/notes/"

if [ "$#" -eq 0 ]; then
	cd "$NOTES_PATH"
        nvim scratch.*.md
elif [ "$#" -eq 1 ] && [ "$1" == "sync" ] ; then
	cd "$NOTES_PATH"
        git add .
	git commit -m'sync'
	git push

elif [ "$#" -eq 1 ] && [ "$1" == "showme" ] ; then
	cd "$NOTES_PATH"
	
	arr=(`grep "#show_me" *.md -l`)
	len=${#arr[@]}
	rnd=$((1 + $RANDOM % $len))
	rndfile=${arr[$rnd]}
	vim $rndfile
elif [ "$#" -eq 1 ] && [ "$1" == "init" ] ; then
	mkdir -p ~/documents
	git clone git@github.com:jaroslavknotek/notes_vault.git --config core.sshCommand="ssh -i ~/.ssh/id_rsa"     ~/documents/notes_vault

else
	echo "Unexpected parameters"
	print_help
fi

