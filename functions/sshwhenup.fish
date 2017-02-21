function sshwhenup --argument host user args
test -z "$host"
and return 1
set -l starttime (date +%s)
set -l sleep 5
set -l user_at (not test -z "$user"; and echo -n $user@)
echo -s (tput smso) "Attempting to connect to host " (set_color green) $host (set_color normal)
while true
debug "trying %s" (echo $args $userat$host)
set -l precmdtime (date +%s)
echo

if set up (ping -c 1 -W 1 $host ^&-) #>/dev/null ^/dev/null #apparently error redir fucked the status??
debug "ssh $user_at$host"
ssh $args $user_at$host ^&-
else if set up (ping -c 1 -W 1 $host.local ^&-) #>/dev/null ^/dev/null
ssh $args $user_at$host.local ^&-
debug "ssh $user_at$host.local"
end
set -l postcmdtime (date +%s)

test (math "$postcmdtime - $precmdtime") -gt 30 #reset if been connected
and set starttime $postcmdtime
echo -s "Host" (set_color green) " $host " (set_color --bold brred) "not seen for " (set_color brblue)(math (date +%s) - $starttime) (set_color normal) "s"
set -l random (math (random)/5000) #randomize so all dont hit at once..
spin "sleep (math $random + $sleep)"
tput cuu 2 #3 #4
end
end
