function hide --description 'remove passed strings from piped text'
	while read -l pipe
        debug "line: %s" $pipe
        set piped $piped $pipe
    end
    debug "numlines: %s" (count $piped)
    and for string in $argv
        set piped (string replace --all "$string" '' $piped)
        debug "changed to: %s" $piped
    end
    echo -ns $piped\n
end
