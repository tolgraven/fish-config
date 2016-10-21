function htop-mini
	itermprofileswitch "tmux attach -t htop-mini ^&-" standard $argv
    or itermprofileswitch "tmux new -s htop-mini fish -c 'sudo htop'" htop-mini $argv
end
