#!/bin/bash
# recover.sh
source ./init.conf
for md5 in $*
do
	recover_file=$(cat ${TRASH_META} | grep ${md5} | cut -d ';' -f1 | cut -d ':' -f2)
	if [ -z ${recover_file} ]
	then
		echo -e "\e[31m WARN \e[0m: can not locate recover file, perhaps the md5(${md5}) you input is invalid"
	else
		if [ ! -e ${TRASH}/${md5} ]
		then
			echo -e "\e[31m WARN \e[0m: ${TRASH}/${md5} not exists!"
		else
			mv ${TRASH}/${md5} ${recover_file}
			if [ $? != 0 ]
			then
				dir_path=$(echo -n ${recover_file} | rev | cut -d '/' -f 2- | rev)
				mkdir -p ${dir_path}
				if [ $? != 0 ]
				then
					echo "failed to create directory ${dir_path}"
				else
					# parent dies have been created, try mv again
					mv ${TRASH}/${md5} ${recover_file}
				fi
			fi
			# the file has been recovered, remove the specific line from meta file
			sed -ie "/${md5}/d" ${TRASH_META}
		fi
	fi
done

