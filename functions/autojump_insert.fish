function autojump_insert --description 'use autojump to put path at cursor'
    set -l token (commandline --current-token)
    set -l output (autojump $token)
    set -l completions (complete --do-complete="j $token"| while read line; autojump $line | string replace $HOME '~'; end)
    echo -ns $completions\n | slmenu -i -l (count $completions) | read -l choice

    if test -d (string replace '~' $HOME $choice) #valid dir
        set path (string escape --no-quoted "$choice")
        debug "$path"
        test (string sub -s 1 -l 1 $path) = \\
        and set path (string sub -s 2 -l (string length $path) "$path")
        debug "$path"
        commandline --current-token $path
        commandline --insert "/" #" " #better to be able to look for files in dir
        tput dl1
        tput cuu1
        commandline -f repaint
    else #trigger completion
        echo BORKEN
    end
end
