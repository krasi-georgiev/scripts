#!/bin/bash
f=$1
u=$2
p=$3
d=$4
h=${5-127.0.0.1}

run_message="Please run using /script_name importFolder user password database host(optional defaults to 127.0.0.1)"

if [ -z "$f" ] || [ -z "$u" ] || [ -z "$p" ] || [ -z "$d" ]  ; then
        echo $run_message;
        exit
fi


for T in $f/*.sql; do
    echo "importing  $T"
    mysql -u root -h$h -p$p --force $d < "$T"
done;

