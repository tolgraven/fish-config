function htop
	if tmux has -t htop ^&-
        #itermprofileswitch "tmux attach -t htop ^&-" standard $argv
    else
        #itermprofileswitch "tmux new -s htop fish -c 'command sudo htop'" htop $argv
    end
    itermprofileswitch "sudo htop" htop $argv #others are being a bit weird cpu wise? hmm. tmux process holding it would jump up to 10-50% cpu every other or third tick..
end
