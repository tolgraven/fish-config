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
for i in (seq 1 5)
imgcat ~/Documents/wait_16.gif
end
tput civis
test -z "$argv[1]"
and fzf | read -l result #highlight with cgrep fucks when search stuff with . in name...
or begin
if test $searchmode = 'find . '
eval $searchmode | grep -i "$search" | grep -v ".git" >$searchdump
else
mdfind -name "$search" | grep -i "$search" | grep -v ".git" >$searchdump
locate "$search" | grep -i "$search" | grep -v ".git" >>$searchdump
end
end
test -s $searchdump
or find . | grep -i "$search" >>$searchdump
sort $searchdump | uniq | string replace -- "/Users/"(whoami) '~' >$searchdump

tput cnorm
command cat $searchdump | highlight | fzf --ansi --query "$search " | read -l result

tput cuu 5
#tput el1
clear_below_cursor

test -z "$result"
and return 1
set result (string replace '~' /Users/(whoami) $result)
if test -d $result
and not string match -q -a -r '.app|.vst|.component' -- (string sub --start=-9 -- $result)
test -d "$result/Contents"
and cd $result/Contents
or eval cd $result
else if test (count $argv) -lt 3
and not type -q $program
cd (dirname (echo $result)) #gets dir part of complete path
and commandline (echo -n "" \"(basename $result)\" ) #gets file part of complete path
and commandline -C 0
else
eval "open "$result" -a "$program""
end
end
