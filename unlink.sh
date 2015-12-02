#!/bin/bash
dir=$(dirname `readlink -f $0`);
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

