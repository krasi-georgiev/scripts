#!/bin/bash
f=$1
u=$2
p=$3
d=$4
h=${5-127.0.0.1}

run_message="Please run using /script_name \"importFolder/fileName(or \\* for all)\" user password database host(optional defaults to 127.0.0.1)"

if [ -z "$f" ] || [ -z "$u" ] || [ -z "$p" ] || [ -z "$d" ]  ; then
        echo $run_message;
        exit
fi


for T in $f; do
    file=$(basename $T)
    table=${file%.*}
    echo "<<<<<  importing  $T into $d.$table  >>>>>  "
    mysql -C --show-warnings -u root -h$h -p$p --force $d < "$T"
#    mysqlimport --use-threads=3 --debug-info -u root -h$h -p$p --force -ivL $d "$T"
    	#first need to create the tables so run the first statment from the file which is the CREATE TABLE
#	sed '/INSERT/Q' $T | mysql -u root -h$h -p$p --force $d 
#	mysql --local-infile -u root -h$h -p$p --force -C --show-warnings -e "LOAD DATA LOCAL INFILE '$T' INTO TABLE $d.$table;"
#	mysql --local-infile -u root -h$h -p$p --force -C --show-warnings -e  \
#	"LOAD DATA LOCAL INFILE '$T' INTO TABLE $d.$table;FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'"
done;
