#!/bin/bash -e

port=1234

# kill if exist
ss -lptnH "sport = :$port" \
| awk -F'[=,)]' '{print $3}' \
| xargs -r sudo kill -9
ssh -NL $port:localhost:$port stinger

#export KEEPASS_DB_PATH="$HOME/keepass-db/acafuel.kdbx"
#pass_id="kobka-stinger-ssh"
#pass=$(,getpass_stdout.sh --entry-id "$pass_id")

#sshpass -p $pass ssh -NL $port:localhost:$port stinger
