function __tol_toggle_comment_commandline --description 'Comment/Uncomment the current line' --argument where
	test -z $where
    and set where beginning

    if test $where = beginning
        set -l cmdlines (commandline)
        #set -l cmdlines2 (commandline -c)
        set -l linepos (commandline -L)
        set -l buffpos (commandline -C)

        for i in (seq 1 (count $cmdlines\n))
            if test $i -eq $linepos
                or set -q continues
                set cmdlines[$i] \#$cmdlines[$i]
                set cmdlines[$i] (string replace -r '^##' '' $cmdlines[$i]) #what ^ thing does?
                #debug $cmdlines[$i]

                set -e continues
                string match (string split "" -- $cmdlines[$i])[-1] \\
                and set continues #test if line ends with \, comment next line
            end
        end
        commandline -r $cmdlines
        commandline -C $buffpos

    else if test $where = end
        commandline -f end-of-line
        commandline -i ' # '
    end
end
