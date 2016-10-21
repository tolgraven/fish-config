function vimcat
	not test -z "$argv[1]"
    and switch $argv[1]
        case '-c' '--cmd' '-u'
            debug "c switch"

            #case '-n'
            #set argv[1] '-c "number"'
        case '-*'
            debug "piping cat to vimcat..."
            command cat $argv | vimcat
            return $stat
    end
    debug "straight up vimcat homie"
    command vimcat $argv
end
