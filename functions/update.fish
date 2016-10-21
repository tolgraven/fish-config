function update
	type -q teamocil
    and tmux has-session -t update
    and tmux send-keys -t update teamocil\ update C-m
    and tmux attach -t update
    or byobu new-session -s update fish -c "teamocil update" ^&-
    #type -q tmuxinator
    #and tmuxinator start update
    or old-update

    and echo -s "Update completed in " (set_color purple) (echo $CMD_DURATION | humanize_duration) (set_color normal)
end
