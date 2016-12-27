function emojify
	#string match -q -- (commandline -t) '*:*'
    #commandline (string replace --all -- ':' '' (commandline -t))
    if string match -- '-*' $argv
        or string match -- ':*' $argv
        command emojify $argv #pass through if flag or using :
    else
        for arg in $argv
            command emojify :$arg:
        end
    end
end
