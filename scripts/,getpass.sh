#!/bin/bash

set -eo pipefail

echo "$1"

,getpass_stdout.sh $@ | xsel -ib
