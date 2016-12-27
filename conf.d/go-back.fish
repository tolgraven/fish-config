function go-back --description "Prints the visited directories"
    if count $argv > /dev/null
        set -l string (type -t string ^ /dev/null)
        if test "$string" = builtin
            cd (string replace -r '^\d+:' '' -- $argv[1])
        else
            cd (printf "%s\n" $argv[1] | sed -r 's/^[0-9]+://')
        end
				tput cuu1 
        return
    end

    set -l alldirs $dirprev $dirnext
    set -l dirhist
    for dir in $alldirs[-1..1]
        if test -d "$dir" -a ! \( $dir = $PWD \)
            if not contains -- $dir $dirhist
                set dirhist $dirhist $dir
                echo (count $dirhist):$dir
            end
        end
    end
end
complete -c go-back -x -a "(go-back)"

function __fish_go-back
    if commandline --search-mode
        return
    end

    set -l cmd (commandline -po)
    if count $cmd > /dev/null
        if test "$cmd[1]" = "go-back"
            commandline -f execute
            if commandline --paging-mode
                commandline -f execute
            end
        end
        return
    end

    set -l dirhist (go-back)
    if test -n "$dirhist"
        commandline -r " go-back "
        commandline -f complete down-line
        return
    end

    # printf "<directory history is empty>"
    # printf "\n%.0s" (fish_prompt)
    # commandline -f repaint
end

# bind \eh '__fish_go-back'
