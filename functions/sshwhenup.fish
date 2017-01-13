function sshwhenup --argument host user args
    test -z "$host"
    and return 1
    set -l starttime (date +%s)
    set -l userat (not test -z "$user"; and echo -n $user@)
    echo -s (tput smso) "Attempting to connect to host " (set_color green) $host (set_color normal)
    while true
        #debug "trying %s" (echo $args $userat$host)
        set -l precmdtime (date +%s)
        echo #\n #\n

        if ping -q -c 1 $host ^&- >&-
            ssh $args $userat$host ^&-
        else if ping -q -c 1 $host.local ^&- >&-
            ssh $args $userat$host.local ^&-
        end
        set -l postcmdtime (date +%s)

        test (math "$postcmdtime - $precmdtime") -gt 30 #reset if been connected
        and set starttime $postcmdtime
        echo -s "Host" (set_color green) " $host " (set_color --bold brred) "not seen for " (set_color brblue)(math (date +%s) - $starttime) (set_color normal) "s"
        set -l random (math (random)/5000)
        set -l sleep 5
        spin "sleep $random; sleep $sleep"
        tput cuu 2 #3 #4
    end
end
