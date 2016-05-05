#!/bin/bash
if [[ $1 && $2 ]] ; then
	folder_url=$1
	folder_size=$(du -ms $1 | cut -f1)
	folder_limit=$2


	if [ "$folder_size" -gt "$folder_limit" ] ; then
            echo "Deleting Files"
            while [ "$folder_size" -gt "$folder_limit" ]; do
                find $folder_url -type f -printf "%T@ %p \n" | sort -n -r -k 1,1 | sed 's/^[0-9]* //' |tail -1|cut -d" " -f 2-|tr -d '\n'|sed 's/.$//'|xargs -0 rm -v	 	folder_size=$(du -ms $1 | cut -f1)
            done
	else  echo "Folder size under set limit"

	fi

	#deleting empty folders
	find $folder_url -type d -empty -delete -printf "deleting empty dir: %p \n"
else  echo "
EXPECTED ARGUMENTS !!!

folder_size_limit.sh /folder/name size_in_MB

example   folder_size_limit.sh /var/log/nginx 20
"
fi
exit 0
