function lnav
	if test -z $argv
        and psc tmux >/dev/null
        if tmux has -t lnav ^&-
            debug "attached to tmux"
            itermprofileswitch "tmux attach -t lnav ^&-" standard $argv
        else
            debug "creating new tmux lnav session.."
            itermprofileswitch "tmux new -s lnav fish -c 'command lnav'" lnav $argv
        end
    else
        debug "vanilla lnav.."
        command lnav $argv
    end
    #itermprofileswitch "byobu attach -t lnav ^&-" standard $argv
    #or itermprofileswitch "byobu new -s lnav fish -c 'command lnav -r'" lnav $argv
end
