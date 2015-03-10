#!/bin/bash

tmux='/usr/bin/tmux'
name='pc_status'


tmux_init(){
    ${tmux} -2 new-session -d -s ${name}
	${tmux} split-window -v
	${tmux} select-pane -t 0
	${tmux} split-window -h

	${tmux} select-pane -t 0
	${tmux} send-keys "ifstat" C-m

	${tmux} select-pane -t 1
	${tmux} send-keys "htop" C-m

	${tmux} select-pane -t 2
	${tmux} send-keys "tail -f /tmp/php_error.txt" C-m

	${tmux} -2 attach -t ${name}
}

if `${tmux} has-session -t ${name} 2>/dev/null` ; then
	${tmux} -2 attach -t ${name}
else
	tmux_init
fi

