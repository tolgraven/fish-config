function tree --description 'limits to 300'
set -l limit 300 #limits recursion
if not test -z $argv
set dir $argv
else
set dir .
end
command tree -Cx -L 3 --filelimit $limit --noreport --dirsfirst $dir | string replace '>' (set_color -o red)'>'(set_color bryellow) | string replace $HOME (set_color -o yellow)'~'(set_color normal) | string replace --all -- '   ' ' ' | string replace --all -- '── ' '─' | string replace --all -- '│' ' ' | string replace --all -- '├' ' ' #go
end
