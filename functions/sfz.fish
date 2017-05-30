function sfz --description 'search (mdfind) then cd to result and optionally execute app' --argument search program
set searchdump "/tmp/sfzsearchtmp"
set -l searchmode "search " #'mdfind -name "$search" | cgrep -i "$search" '
switch "$search"
case "-l" # use locate instead of search (mdfind)
echo "locate parallel with mdfind already implemented by default"
return 1
case "-f" # use find...
set searchmode 'find . '
set search $program
if test (count $argv) -gt 2
set program $argv[3]
set -e argv[3]
end
end
tput civis
imgcat ~/Documents/wait_16.gif

test -z "$argv[1]"
and fzf | read -l result #base fzf if not given anything to search for
or begin
if test $searchmode = 'find . ' #regular in dir
eval $searchmode | grep -i "$search" | grep -v ".git" >$searchdump
else #spotlight + locate
mdfind -name "$search" | grep -i "$search" | grep -v ".git" >$searchdump
locate "$search" | grep -i "$search" | grep -v ".git" >>$searchdump
end
end
test -s $searchdump
or find . | grep -i "$search" >>$searchdump

sort $searchdump | uniq | string replace -- "/Users/"(whoami) '~' >$searchdump #common: sort, filter, fix paths
set -l height (math "$LINES / 2")
set -l hitcount (command cat $searchdump | wc -l)
test "$hitcount" -lt "$height"
and set height $hitcount
tput cnorm
tput cuu 2
command cat $searchdump | highlight | command fzf --reverse --height=$height --preview-window=down:5 --preview='head -n 30 {} | highlight' --query "$search " | read -l result

test -z "$result"
and return 1
set result (string replace '~' $HOME $result)
if test -d "$result"
and not string match -q -a -r '.app|.vst|.component' -- (string sub --start=-9 -- $result)
test -d "$result/Contents"
and cd $result/Contents
or eval cd "$result"
else if test (count $argv) -lt 3
and not type -q $program
cd (dirname (echo $result)) #gets dir part of complete path
and commandline (echo -n "" \"(basename $result)\" ) #gets file part of complete path
and commandline -C 0
else
eval "open "$result" -a "$program""
end
end
