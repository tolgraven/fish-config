function jstat
	set -l dirs (j --stat | ccat --color=always) #| read --array -l dirs
    if not test -z $argv
        for arg in $argv
            echo -s $dirs\n \n | cgrep $arg
        end
    else
        or echo -ns $dirs\n
    end
end
