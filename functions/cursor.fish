function cursor --description 'move fish cursor' --argument pos
	if test -z $argv
        commandline --cursor
    else if test $pos -ge 0
        commandline --cursor -- $pos
    else
        set way (string sub -s 1 -l 1 -- $pos)
        set amount (string sub -s 2 -- $pos)
        switch $way
            case '+' '-'
                commandline --cursor -- (math (commandline --cursor) $way $amount)
        end
    end
end
