function lnav-mini
	itermprofileswitch "tmux attach -t lnav-mini ^&-" standard $argv
    or itermprofileswitch "tmux new -s lnav-mini fish -c 'command lnav -r'" lnav-mini $argv
end
