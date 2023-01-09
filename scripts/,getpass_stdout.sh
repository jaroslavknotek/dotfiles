#!/bin/bash

set -eo pipefail

DBS_ROOT=/home/jry/keepass-db/
DEFAULT_DB_PATH=/home/jry/keepass-db/pass.kdbx
MAYBE_ENTRY_ID=

while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "Bash wrapper around keepass app"
      echo " "
      echo "options:"
      echo "-h, --help                print this help"
      echo "-d, --use-default-db      don't use default db and let user pick"
      echo "--entry-id                entry to be picked without user interaction" 
      exit 0
      ;;
    -d|--use-default-db)
      KEEPASS_DB_PATH=$DEFAULT_DB_PATH
      shift
      ;;
    --entry-id*)
      shift
      MAYBE_ENTRY_ID="$1"
      shift
      ;;
    *)
      break
      ;;
  esac
done

pushd ~/apps/keepassxc_q_cli > /dev/null
source .venv/bin/activate

if [ -z "${KEEPASS_DB_PATH}" ]; then
	DB_PATH_ARG=
else
	DB_PATH_ARG="--db_path $KEEPASS_DB_PATH"
fi

set +e
if [ -z "${MAYBE_ENTRY_ID}" ]; then
	OUTPUT=$(python python/cli.py from-list --dbs_root $DBS_ROOT $DB_PATH_ARG 2>&1)	
else
	OUTPUT=$(python python/cli.py by-id --dbs_root $DBS_ROOT $DB_PATH_ARG --entry_id "$MAYBE_ENTRY_ID" 2>&1)
fi

RES=$?	
set -e
if [ $RES -eq 0 ]; then
	echo "$OUTPUT" | tr -d '\n'	    
	notify-send --expire-time 1000 "getpass" "password copied" 
else
	notify-send --expire-time 3000 -u critical "getpass"  "$(echo $OUTPUT| tail -n1)"
fi



popd > /dev/null

