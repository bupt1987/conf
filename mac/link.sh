#!/bin/bash
dir=$(cd `dirname $0`; pwd);
list=(`cat "$dir/filelist"`);

echo ${dir}/list

for file in ${list[@]}
do
	if [ ! -f ~/${file} ]; then
		if [ -f ${dir}/${file} ]; then
			ln -s -f ${dir}/${file} ~/${file}
		else
			ln -s -f $(dirname ${dir})/${file} ~/${file}
		fi
	fi
done

if [ ! -d ~/.tmp ]; then
	mkdir ~/.tmp
fi
