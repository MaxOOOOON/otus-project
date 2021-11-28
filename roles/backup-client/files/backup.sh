#!/usr/bin/bash 

BACKUP_USER=root
BACKUP_HOST=192.168.255.5
BORG_PASSPHRASE='C7NNyjt5TZD3xztnxcb3kx'
REPO=$BACKUP_USER@$BACKUP_HOST:/var/backup/mysql





ssh $BACKUP_USER@$BACKUP_HOST "mkdir -p /var/backup/mysql"

export BORG_PASSPHRASE="$BORG_PASSPHRASE"
borg info $BACKUP_USER@$BACKUP_HOST:/var/backup/mysql > /dev/null
backup_init=$?

if [ ${backup_init} -ne 0 ]
then 
borg init --encryption=repokey $BACKUP_USER@$BACKUP_HOST:/var/backup/mysql
fi



borg create -v $REPO::'{hostname}-{now}'  /var/lib/mysql/
backup_exit=$?

borg prune -v $REPO --keep-within=3m --keep-monthly=12 --keep-yearly=1 


if [ ${backup_exit} -eq 0  ] 
then 
echo 'Backup complete succeeded'
else
echo 'Attention!!!!!!'
fi


# date +"%Y-%m-%d-%H-%M"
# export BORG_REPO='ssh://user@backup_server/mnt/backup/linode_01'
# export BORG_PASSPHRASE='set_your_passpharase'
# export BORG_RSH='ssh -i /home/kannan/.ssh/id_rsa_backups'