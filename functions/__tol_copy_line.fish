function __tol_copy_line
	### ADD SUPPORT FOR COPYING FISH-SELECTED LINES instead of just yanking dem
    # so like check is selecting
    if set -q __tol_fish_selecting
        set currbuff (commandline)
        set currpos (commandline -C)
        commandline -f kill-selection
        __tol_toggle_selecting
        commandline -f repaint

        #commandline ""
        #commandline (commandline -f yank)

        set rest (commandline)
        #set -l selection (echo $currbuff | grep -v --only-matching $rest)
        set selection (string match -all $currbuff $rest) #--invert
        echoerr $selection\n
        echo -n $selection\n | pbcopy
        commandline $currbuff
        commandline -C $currpos
    else
        set -l currline (commandline -L)
        #echoerr (echoright $currline); echoerr (commandline)
        set -l cmdline (echo -n (commandline)\n)
        echo -n $cmdline[$currline] | pbcopy
        #give notice that dis has happened somehow
    end
end
