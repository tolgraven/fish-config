function autojump_fzf --description 'use autojump to put path at cursor' --argument mode lucky
set -l token (commandline --current-token)
set -l output (autojump $token)
if not test -z "$lucky"
set choice $output #$completions[1]
else
set completions (complete --do-complete="j $token"| while read line; echo (string split '__' $line)[-1] | string replace $HOME '~'; end)
echo -ns $completions\n | fzf --height=(count $completions) --reverse | read choice
end
if test -d (string replace '~' $HOME $choice) #valid dir
set path (string escape --no-quoted "$choice")
test (string sub -s 1 -l 1 $path) = \\
and set path (string sub -s 2 -l (string length $path) "$path")
debug "$path"
else #trigger completion
echoerr BORKEN autojump
return 1
end

switch "$mode"
case 'insert'
commandline --current-token $path
commandline --insert "/" #" " #better to be able to look for files in dir
#tput dl1
#tput cuu1
commandline -f repaint
case 'cd'
commandline --current-token ''
cd $path
end
end
