function echoright
	debug "numlines %s" (count $argv\n)
    for line in $argv
        #debug "writing line: %s" $line
        printf "%*s\n" (tput cols) $line
    end
end
