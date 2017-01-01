function fzf-complete -d 'fzf completion and print selection back to commandline'
    set -l complist (complete -C(commandline -c))
    set -l result
    string join -- \n $complist | sort | eval (__fzfcmd) -m --tiebreak=index --select-1 --exit-0 --header '(commandline)' | cut -f1 | while read -l r; set result $result $r; end

    for i in (seq (count $result))
        set -l r $result[$i]
        ## We need to escape the result.
        switch (string sub -s 1 -l 1 -- (commandline -t))
            case "'"
                commandline -t -- (string escape -- (eval "printf '%s' '$r'"))
            case '"'
                set -l quoted (string escape -- (eval "printf '%s' '$r'"))
                set -l len (string length $quoted)
                commandline -t -- '"'(string sub -s 2 -l (math $len - 2) (string escape -- (eval "printf '%s' '$r'")))'"'
            case '~'
                commandline -t -- (string sub -s 2 (string escape -n -- (eval "printf '%s' '$r'")))
            case '*'
                commandline -t -- (string escape -n -- (eval "printf '%s' '$r'"))
        end
        [ $i -lt (count $result) ]; and commandline -i ' '
    end

    commandline -f repaint
end