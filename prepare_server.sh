#! /bin/bash
DAILYLOGFILE="/var/log/mysql_backup.daily.log"
rm "$DAILYLOGFILE"
/usr/bin/touch "$DAILYLOGFILE"
/bin/chown backuppc:backuppc "$DAILYLOGFILE"
/bin/chmod 777 "$DAILYLOGFILE"

EMAIL="backups@vip-consult.solutions"

HOST=$1
BACKUP_DIR_MYSQL="$2/$1/$3"
BACKUP_DIR_PSQL="$4/$1/$5"
CONTAINER_MYSQL=$3
CONTAINER_PSQL=$5
SSH_USER=$6
MYSQL_NETWORK=$7
PSQL_NETWORK=$8
run_message="Please run using /script_name host backup_dir_mysql mysql_container backup_dir_psql psql_container ssh_user mysql_network psql_network"

if [ -z "$HOST" ] || [ -z "$BACKUP_DIR_MYSQL" ] || [ -z "$BACKUP_DIR_PSQL" ]|| [ -z "$CONTAINER_MYSQL" ]|| [ -z "$CONTAINER_PSQL" ] || [ -z "$SSH_USER" ] || [ -z "$MYSQL_NETWORK" ] || [ -z "$PSQL_NETWORK" ]  ; then
        echo $run_message;
        exit
fi

echo -e "Starting Mysql Docker backup conatiner with BACKUP FOLDER:$BACKUP_DIR_MYSQL , CONTAINER:$CONTAINER_MYSQL , HOST: $HOST ! \n"
/usr/bin/ssh  -x -l $SSH_USER $HOST \
sudo docker run --rm --net $MYSQL_NETWORK \
--cpu-shares 128 \
-v /home/vipconsult/mysql/.my.cnf:/root/.my.cnf \
-v $BACKUP_DIR_MYSQL:$BACKUP_DIR_MYSQL \
-e backup_dir=$BACKUP_DIR_MYSQL \
-e backup_container=$CONTAINER_MYSQL \
vipconsult/mysql_backup \
  2>  >(/usr/bin/tee -a ${DAILYLOGFILE} >&2)


echo \n \n \n ".";

echo -e "Starting Psql Docker backup conatiner with BACKUP FOLDER:$BACKUP_DIR_PSQL , CONATINER:$CONTAINER_PSQL , HOST: $HOST ! \n"
/usr/bin/ssh  -x -l $SSH_USER $HOST \
sudo docker run --rm --net $PSQL_NETWORK \
--cpu-shares 128 \
-v $BACKUP_DIR_PSQL:$BACKUP_DIR_PSQL \
-e backup_dir=$BACKUP_DIR_PSQL \
-e backup_container=$CONTAINER_PSQL \
  vipconsult/psql_backup \
  2>  >(/usr/bin/tee -a ${DAILYLOGFILE} >&2)


if [ -s $DAILYLOGFILE ]; then    #email only if error occurred - because log file exists
    cat "$DAILYLOGFILE" | /sbin/bsmtp -f backuppc@vip-consult.co.uk -h smtp -s "Servers Backup Log" $EMAIL

    if [[ $? -ne 0 ]]; then
        echo -e "ERROR:  Error log  could not be emailed to you! \n";
        else
        echo -e "Backup Error log has been emailed to $EMAIL ! \n"
    fi
fi
