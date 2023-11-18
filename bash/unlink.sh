#!/bin/bash
cd `dirname $0`
dir=(`pwd`);
list=(`cat "$dir/filelist"`);

echo ${dir}/filelist

for file in ${list[@]}
do
  echo $file
	if [ -f ~/${file} ]; then
		rm ~/${file}
	fi
done

if [ -d ~/.tmp ]; then
	rm -fr ~/.tmp
fi

