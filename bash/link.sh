#!/bin/bash
cd `dirname $0`

dir=`pwd`;
list=(`cat "$dir/filelist"`);

echo ${dir}/list

for file in ${list[@]}
do
	if [ ! -f ~/${file} ]; then
		ln -s -f ${dir}/${file} ~/${file}
	fi
done

if [ ! -d ~/.tmp ]; then
	mkdir ~/.tmp
fi
