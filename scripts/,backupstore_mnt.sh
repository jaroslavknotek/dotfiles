export KEEPASS_DB_PATH="$HOME/keepass-db/acafuel.kdbx"
pass_id="Microsoft Azure windowsazure CVREZ"
pass=$(,getpass_stdout.sh --entry-id "$pass_id")


mount_path=/cvr_backupstore
username=jaroslav.knotek
server_name=//rv-file-cvb.ad.ujv.cz/cv_backupdatastore/

sudo mount --mkdir -t cifs $server_name $mount_path -o username=$username,password=$pass
