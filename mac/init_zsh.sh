#!/bin/bash
dir=$(cd `dirname $0`; pwd);

if [ ! -d ~/.oh-my-zsh/themes/ ]; then
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ ! -d ~/.oh-my-zsh/themes/ ]; then
	echo 'install oh-my-zs first'
	exit 1
fi

if [ ! -f ]; then
	rm -fr /tmp/xxf.zsh-theme
	git clone git@gist.github.com:18fd7c24360c68bab884.git /tmp/xxf.zsh-theme
	rm -f ~/.oh-my-zsh/themes/xxf.zsh-theme
	cp /tmp/xxf.zsh-theme/xxf.zsh-theme ~/.oh-my-zsh/themes/
fi

if [ -f ~/.zshrc-backup ]; then
	rm -f ~/.zshrc-backup
fi
cat ~/.zshrc | sed 's/ZSH_THEME=".*/ZSH_THEME="xxf"/g' > ~/zshrc
mv ~/.zshrc ~/.zshrc-backup
mv ~/zshrc ~/.zshrc

echo 'init success'

