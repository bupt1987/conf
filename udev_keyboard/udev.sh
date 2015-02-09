#!/bin/bash
sudo -u "${USER}" /usr/bin/xmodmap -display :0 ~/conf/.Xmodmap >/dev/null 2>&1 &
