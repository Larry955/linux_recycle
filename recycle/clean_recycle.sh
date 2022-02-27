#!/bin/bash
# clean_recycle.sh
source ./init.conf
seven_days_before=$(date +%G-%m-%dT-%T --date='7 day')
sdb_ts=$(date -d ${seven_days_before} +%s)
if [ ! -f ${TRASH_META} ]
then
	echo "\e[31m WARN \e[0m: meta file [${TRASH_META}] not exists!"
	exit
else
	while read LINE
	do
		delete_time=$(echo -n ${LINE} | cut -d ';' -f 2 | cut -d ':' -f1)
		md5=$(echo -n ${LINE} | cut -d ';' -f 3 | cut -d ':' -f1)
		if [ -z ${delete_time} ]
		then
			echo "invalid time"
		else
			delete_ts=$(date -d ${delete_time} +%s)
		fi
		if [ ${delete_ts} < ${sdb_ts}]
		then
			if [ ! -e ${TRASH}/${md5} ]
			then
				echo "md5[${md5}] file not exists!"
			else
				# do real remove
				rm -rf ${TRASH}/${md5}
				sed -ie "/${md5}/d" ${TRASH_META}
			fi
		fi
	done < ${TRASH_META}
fi

