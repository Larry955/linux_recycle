#!/bin/bash
# remove.sh

source ./init.conf
# init
if [ ! -d ${TRASH} ]
then
	mkdir ${TRASH}
	echo “recycle ${TRASH} created”
fi

if [ ! -f ${TRASH_META} ]
then
	touch ${TRASH_META}
	echo “file ${TRASH_META} created”
fi

# do remove
for f in $*
do
	if [ ! -e ${f} ]
	then
		echo -e "\e[31m WARN \e[0m: ${f} not exists"
	else
		real_path=$(realpath ${f})
		if [ ${real_path} = ${TRASH} -o ${real_path} = ${TRASH_META} ]
		then
			echo -e "\e[31m WARN \e[0m: ${f} not exists"
		else
			cur_time=$(date +%G-%m-%dT%T)
			unique_file=${real_path}+${cur_time}
			encode_file=$(echo -n ${unique_file} | md5sum | cut -d ' ' -f1)
			# write to meta file
			echo "[FILE NAME]:${real_path}; [DELETE TIME]:${cur_time}; [MD5]:${encode_file}" >> ${TRASH_META}
			# mv the deleted file to recycle
			mv $f ${TRASH}/${encode_file}
		fi
	fi
done
