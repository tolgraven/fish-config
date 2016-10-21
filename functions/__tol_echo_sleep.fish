function __tol_echo_sleep --argument text times sleepfor
	set -q $sleepfor
    and set sleepfor 0.1
    set length (string length $text)
    if test $length -gt 1
        set times $length
        set text (string split "" $text)
    else if test $length -gt 0 # 1 ch, normal to output repeatedly #
    end
    test (count $text) -gt 1
    or set -l same
    for i in (seq 1 $times)
        set -q same
        and echo -n -s $text
        or echo -n -s $text[$i]
        sleep $sleepfor
    end
end
