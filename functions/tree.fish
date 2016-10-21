function tree --description 'limits to 300'
	#echo "limits to 300 files"
    if not test -z $argv
        set dir $argv
    else
        set dir .
    end
    command tree -Cx -L 3 --filelimit 300 --noreport --dirsfirst $dir | string replace '>' (set_color -o red)'>'(set_color bryellow) | string replace $HOME (set_color -o yellow)'~'(set_color normal)
end
