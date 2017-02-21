function clone --description 'clone git repo from url or gh usr/repo in clipboard'
set -l repo (pbpaste)
switch "$repo"
case '' #empty
return
case 'http*://*' '*www*' '*.com*' '*.git' 'git://*'
git clone "$repo" $argv | highlight
case '*'
hub clone "$repo" $argv | highlight
end
set -l clonedir (ls -t)[1]
test -d $clonedir
and cd $clonedir
and devla
end
