function __fish_move_last --description 'Move the last element of a directory history from src to dest' --argument src dest
	#set -l src $argv[1] #set -l dest $argv[2]
    set -l size_src (count $$src)
    if test $size_src = 0 # Cannot make this step
        echoerr -ns (set_color red) "Hit end of history" (set_color normal) "."
        sleep 0.1
        echoerr -ns "."
        sleep 0.1
        echoerr -ns "."
        sleep 0.1 #commandline -f repaint
        return 1
    end
    tput civis

    set -g (echo $dest) $$dest (command pwd) # Append current dir to the end of the destination
    set ssrc $$src #test $size_src = 0; or begin; #end
    set -e (echo $src)\[$size_src] # Keep all but the last from the source dir-hist
    builtin cd $ssrc[$size_src] # Change dir to the last entry in the source dir-hist
    debug "unset dirhist part %s" $size_src

    #set -l cwd (basename $ssrc[$size_src]) #set tempshow (echo -n -s $prevs\  ' [' (imgcat $cachedir/directory_(get_label)_16x16.png) (set_color blue) (tput cub 1) $currdir (set_color normal) '] ' $nexts[-1..1]\ )
    set -l cwd $ssrc[$size_src]
    set -l cwd_icon __tols_folder_(get_label)

    set -l dirs $cwd
    for dir in $dirprev[-1..1]
        not contains $dir $dirs
        and set dirs $dir $dirs
    end
    for dir in $dirnext[-1..1]
        not contains $dir $dirs
        and set dirs $dirs $dir
    end
    for i in (seq 1 (count $dirs))
        set icon __tols_folder_(get_label $dirs[$i])
        test "$dirs[$i]" = "$cwd"
        and set dirs[$i] (echo -ns ' [' "$$cwd_icon " (set_color blue) (basename $cwd) (set_color normal) '] ')
        or set dirs[$i] (echo -ns "$$icon ")(basename $dirs[$i])
    end

    for dir in $dirprev
        not contains $dir $uniq_prev
        and set uniq_prev $uniq_prev $dir
    end
    for dir in $dirnext
        not contains $dir $uniq_next
        and set uniq_next $uniq_next $dir
    end #set cachedir ~/.cache/tols/filetypes     #set dirprev $uniq_prev #set dirnext $uniq_next #set -l prevs #set -l nexts
    not test -z "$uniq_prev"
    and for i in (seq 1 (count $uniq_prev))
        #set prevs[$i] (imgcat $cachedir/directory_(get_label "$dirprev[$i]")_16x16.png)(tput cub 1)(basename $dirprev[$i])
        set icon __tols_folder_(get_label $uniq_prev[$i])
        set uniq_prev[$i] (echo -ns "$$icon ")(basename "$uniq_prev[$i]")
    end
    not test -z "$uniq_next"
    and for i in (seq 1 (count $uniq_next))
        #set nexts[$i] (imgcat $cachedir/directory_(get_label "$dirnext[$i]")_16x16.png)(tput cub 1)(basename $dirnext[$i])
        set icon __tols_folder_(get_label "$uniq_next[$i]")
        set uniq_next[$i] (echo -ns "$$icon ")(basename "$uniq_next[$i]")
    end

    #set tempshow (echo -ns $uniq_prev\  ' [' (echo -ns "$$cwd_icon ") (set_color blue) $cwd (set_color normal) '] ' $uniq_next[-1..1]\ )
    set tempshow (echo -ns $dirs\ )

    tput cud1
    tput dl1
    echo -n "$tempshow"
    tput cuu1 #cuu 2
    tput cnorm
    return 0
end
