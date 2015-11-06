各种bash配置

git clone git@github.com:bupt1987/conf.git ~/conf

#连接配置文件
~~~~
linux =>  ~/conf/link.sh
mac   =>  ~/conf/mac/link.sh
~~~~
#使文件生效
~~~~
linux =>  cat ~/conf/bashrc >> ~/.bashrc
mac   =>  ~/conf/mac/init_zsh.sh && cat ~/conf/mac/bashrc >> ~/.zshrc
~~~~
#取消连接
~~~~
linux =>  ~/conf/unlink.sh
mac   =>  ~/conf/mac/unlink.sh
~~~~
