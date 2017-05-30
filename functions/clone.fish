function clone --description 'clone git repo from url or gh usr/repo in clipboard'
set -l repo (pbpaste)
set -l clonedir
switch "$repo"
case '' #empty
return
case 'http*://*' '*www*' '*.com*' '*.git' 'git://*'
git clone --verbose "$repo" $argv | while read line
echo $line
#string match -q 'Cloning into*' $line
#and set clonedir (string split -- "'" $line)[2]
end
case '*'
hub clone "$repo" $argv | highlight
end
set -l clonedir (ls -t | strip_ansi_color )[1]
debug "clonedir: $clonedir"
test -d "$clonedir"
and cd $clonedir
#and devla
and la
end
