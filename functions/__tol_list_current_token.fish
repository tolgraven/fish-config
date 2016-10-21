function __tol_list_current_token --description 'List contents of token under cursor if dir, or of current dir'
	set val (eval echo (commandline -t))
    printf "\n"
    if test -d $val
        ls $val
    else
        set dir (dirname $val)
        if test $dir != . -a -d $dir
            ls $dir
        else
            ls
        end
    end

    set -l line_count (count (fish_prompt))
    if test $line_count -gt 1
        for x in (seq 2 $line_count)
            printf "\n"
        end
    end

    commandline -f repaint
end
