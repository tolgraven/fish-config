function __fish_move_last --description 'Move the last element of a directory history from src to dest'
	set -l src $argv[1]
    set -l dest $argv[2]
    set -l size_src (count $$src)

    if test $size_src = 0 # Cannot make this step
        echoerr -n -s (set_color red) "Hit end of history" (set_color normal) "."
        sleep 0.1
        echoerr -n -s "."
        sleep 0.1
        echoerr -n -s "."
        sleep 0.1
        commandline -f repaint
        return 1
    end
    tput civis
    set -g (echo $dest) $$dest (command pwd) # Append current dir to the end of the destination
    set ssrc $$src
    #test $size_src = 0; or begin; #end
    set -e (echo $src)\[$size_src] # Keep all but the last from the source dir-hist
    builtin cd $ssrc[$size_src] # Change dir to the last entry in the source dir-hist
    debug "unset dirhist part %s" $size_src

    set -l prevs
    set -l nexts
    not test -z $dirprev[1]
    and for i in (seq 1 (count $dirprev))
        set prevs[$i] (basename $dirprev[$i])
    end
    not test -z $dirnext[1]
    and for i in (seq 1 (count $dirnext))
        set nexts[$i] (basename $dirnext[$i])
    end

    #set tempshow (echo -n -s (set_color blue) "dir" (set_color brblue) $size_src (set_color normal) "  " $prevs\  ' [' (set_color blue) (basename $ssrc[$size_src]) (set_color normal) '] ' $nexts[-1..1]\ )
    set tempshow (echo -n -s $prevs\  ' [' (set_color blue) (basename $ssrc[$size_src]) (set_color normal) '] ' $nexts[-1..1]\ )

    #echoerr -n "..." #sleep 0.02 #echoerr -n "$tempshow" " "
    tput cud1
    #tput hpa 0
    tput dl1
    echoright "$tempshow" #sleep 0.25
    tput cuu 2
    tput cnorm
    #commandline -f repaint #gets repainted anyways after echo..

    return 0 # All ok, return success
end
