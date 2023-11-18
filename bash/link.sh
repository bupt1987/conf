#!/bin/bash
cd $(dirname $0)

dir=$(pwd)
list=($(cat "$dir/filelist"))

echo ${dir}/list

for file in ${list[@]}; do
  if [ ! -f ~/${file} ]; then
    ln -s -f ${dir}/${file} ~/${file}
  fi
done

if [[ ! $(cat ~/.bashrc | grep 'if [ -f ~/.bash_init ]; then') ]]; then
  # shellcheck disable=SC2129
  echo 'if [ -f ~/.bash_init ]; then' >>~/.bashrc
  echo '    . ~/.bash_init' >>~/.bashrc
  echo 'fi' >>~/.bashrc
fi

if [[ -f /etc/bash_completion.d/git ]]; then
  if [[ ! $(cat ~/.bashrc | grep 'source /etc/bash_completion.d/git') ]]; then
    # shellcheck disable=SC2129
    echo 'source /etc/bash_completion.d/git' >>~/.bashrc
  fi
fi

if [ ! -d ~/.tmp ]; then
  mkdir ~/.tmp
fi
