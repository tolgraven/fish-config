function run --description 'run passed cmds. no waiting for anything to finish, and output is ignored'
	not test -z "$argv"
    and for cmd in $argv
        fish -c "$cmd" >/dev/null ^&- &
        sleep 0.01
    end
end
