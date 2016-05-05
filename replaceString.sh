#!/bin/bash
folder=$1
old=$2
new=$3


run_message='run using /script_name folder oldWord newWord'

if [ -z "$folder" ] || [ -z "$old" ] || [ -z "$new" ]  ; then
        echo $run_message;
        exit
fi

for i in $folder/*; do
    echo "replacing $old->$new in $i"
    sed -i -e "s/$old/$new/g" "$i"
done

