function __tol_insert_left_paran
	#set -l cmdlines (commandline)
    #set -l split (string split -- '' $cmdlines)
    set -l pos (commandline --cursor)
    #for i in (seq $pos 1)
    #if string match -- $cmdlines[$i] ' '
    #set cmdlines $cmdlines[1..$i]
    #break
    #end
    #end

    commandline --replace --current-token -- '('(commandline --current-token)
    commandline --cursor (math "$pos + 1")
end
