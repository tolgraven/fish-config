function hs
	if test -z $argv[1]
        command hs
    else
        switch $argv[1]
            case '-*'
                debug "opt passed"
                command hs $argv
            case '*'
                debug "no switches"
                command hs -c "$argv"
        end
    end
end
