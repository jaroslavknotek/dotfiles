#!/bin/bash

set -e

SOURCE_ROOT="$HOME/source"
GIT_URI=$1

script_full_path=$(dirname "$0")
user_repo=$($script_full_path/parse_git_name.py $GIT_URI)

DESTINATION="$SOURCE_ROOT/$user_repo"
git clone $GIT_URI $DESTINATION

