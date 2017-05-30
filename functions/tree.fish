function tree --description 'limits to 300'
set -l limit 300 #limits recursion
not test -z "$argv"
and set dir $argv
or set dir .

command tree -Cx -L 3 --filelimit $limit --noreport --dirsfirst $dir | string replace '>' (set_color -o red)'>'(set_color bryellow) | string replace $HOME (set_color -o yellow)'~'(set_color normal) | string replace --all -- '   ' ' ' | string replace --all -- '── ' '─' | string replace --all -- '│' ' ' | string replace --all -- '├' ' ' #go
end
