#!/bin/bash

tmux='/usr/bin/tmux'
name='pc_status'


tmux_init(){
    ${tmux} -2 new-session -d -s ${name}
	#${tmux} split-window -v
	#${tmux} select-pane -t 0
	${tmux} split-window -h

	${tmux} select-pane -t 0
	${tmux} send-keys "dw_terror" C-m

	${tmux} select-pane -t 1
	${tmux} send-keys "ssh dw-user-log '/www/calc_ram.php && tail -F /www/logs/run/scan_*'" C-m

	#${tmux} select-pane -t 2
	#${tmux} send-keys "ssh nova 'tail -F /www/clean_log.log'" C-m

	${tmux} -2 attach -t ${name}
}

if `${tmux} has-session -t ${name} 2>/dev/null` ; then
	${tmux} -2 attach -t ${name}
else
	tmux_init
fi

