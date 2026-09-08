#!/bin/bash

sudo true 

export KEEPASS_DB_PATH="$HOME/keepass-db/acafuel.kdbx"
pass_id="kobka-nas-pass"
pass=$(,getpass_stdout.sh --entry-id "$pass_id")


mount_path=/mnt/kobka-fuel
username=jknotek
server_name=//192.168.61.18/FUEL_CEZ_TEAM

sudo mount --mkdir -t cifs $server_name $mount_path -o username=$username,password=$pass


# HOME
mount_path=/mnt/kobka-home
server_name=//192.168.61.18/home

sudo mount --mkdir -t cifs $server_name $mount_path -o username=$username,password=$pass


mount_path=/mnt/kobka-datasets
server_name=//192.168.61.18/ANNOTATED_DATASETS
sudo mount --mkdir -t cifs $server_name $mount_path -o username=$username,password=$pass


mount_path=/mnt/kobka-ahlberg
server_name=//192.168.61.18/FUEL_AHLBERG_TEAM
sudo mount --mkdir -t cifs $server_name $mount_path -o username=$username,password=$pass


mount_path=/mnt/kobka-framatome
server_name=//192.168.61.18/FUEL_FRAMATOME_TEAM
sudo mount --mkdir -t cifs $server_name $mount_path -o username=$username,password=$pass
