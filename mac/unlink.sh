#!/bin/bash
dir=$(cd `dirname $0`; pwd);
list=(`cat "$dir/filelist"`);

echo ${dir}/list

for file in ${list[@]}
do
	if [ -f ~/${file} ]; then
		rm ~/${file}
	fi
done

if [ -d ~/.tmp ]; then
	rm -fr ~/.tmp
fi
