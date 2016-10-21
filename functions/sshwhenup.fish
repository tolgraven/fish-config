function sshwhenup --argument host user args
	test -z $host
    and return 1
    set -l starttime (date +%s)
    while true
        set -l precmdtime (date +%s)

        echo \n \n
        debug "trying %s" (echo $args (not test -z $user; and echo -n $user@)$host)
        echoerr (echo $args (not test -z $user; and echo -n $user@)$host)
        ping -q -c 1 $host ^&- >&-
        and ssh $args (not test -z $user; and echo -n $user@)$host

        #and break

        set -l postcmdtime (date +%s)

        if test (math $precmdtime - $postcmdtime) -gt 30 #hack to reset if we've been connected
            set starttime $postcmdtime
        end
        echo "Waiting for host" (set_color green)$host (set_color normal)"to appear -" (set_color --bold brred)"not seen for" (set_color brblue)(math (date +%s) - $starttime) "seconds" (set_color normal)
        spin "sleep 1"
        tput cuu 4
    end
end
