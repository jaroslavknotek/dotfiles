#!/bin/bash

set -eo pipefail

if [ $# -eq 0 ]; then
	python3 ~/apps/onepass_cli/cmd_1pass.py get_from_list -p | xsel -ib
	notify-send --expire-time 1000 "getpass" "password coppied" 

elif [[ "$#" -ne 1 ||  $1 != "--stdout" ]]; then
	echo "Invalid argument(s): $# / $1"
	exit 1
else
	python3 ~/apps/onepass_cli/cmd_1pass.py get_from_list -p
fi
 

