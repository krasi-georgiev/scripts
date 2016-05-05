#!/bin/bash
u=$1
p=$2
d=$3
s=${4-127.0.0.1}
f=${5-exportedTables}


run_message="run using /script_name user password database server(optional) exportFolder(optional defaults to exportedTables/database)"

if [ -z "$u" ] || [ -z "$p" ] || [ -z "$d" ]  ; then
        echo $run_message;
        exit
fi



mysql -h$s -u$u -p$p -N -B -e "show tables from $d"| grep -v information_schema |while read T;do
    echo "Backing up $f/$d/$T"
    mkdir -p $f
    mysqldump --skip-comments --compact --insert-ignore -h$s -u$u -p$p $d "$T" > "$f/$T.sql"
done;

