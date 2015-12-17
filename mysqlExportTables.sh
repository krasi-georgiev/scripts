#!/bin/bash
u=$1
p=$2
d=$3
f=${5-exportedTables}


run_message="Please run using /script_name user password database exportFolder(optional defaults to exportedTables)"

if [ -z "$u" ] || [ -z "$p" ] || [ -z "$d" ]  ; then
        echo $run_message;
        exit
fi



mysql -u$u -p$p -N -B -e "show tables from $d"| grep -v information_schema |while read T;do
    echo "Backing up $T"
    mkdir -p $f/$d
    mysqldump --skip-comments --compact -u$u -p$p $d "$T" > "$f/$d/$T.sql"
done;
