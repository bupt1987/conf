#!/bin/bash

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" \
 && git clone git@gist.github.com:18fd7c24360c68bab884.git /tmp/xxf.zsh-theme \
 && mv /tmp/xxf.zsh-theme/xxf.zsh-theme ~/.oh-my-zsh/themes/ \
 && echo "ZSH_THEME=xxf" >> ~/.zshrc \
 && echo 'success'

