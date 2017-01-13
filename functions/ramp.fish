function ramp --description 'smoothly change value' --argument newval getsetfunc time steps
    test -z "$newval"
    and return
    test -z "$time"
    and set -l time 1
    test -z "$steps"
    and set -l steps 20

    set -l curr (eval $getsetfunc)
    set -l diff (math $curr-$newval)
    if test $diff -gt 0
        test $steps -gt $diff
        and set steps $diff
    else
        test $steps -gt (math 0-$diff)
        and set steps (math 0-$diff)
    end

    set -l each (math -s2 "$diff / $steps")
    test $each -eq 0
    and set each 1
    set -l wait (math -s2 "$time / $steps")

    debug "curr %s newval %s diff %s steps %s each %s wait %s" $curr $newval $diff $steps $each $wait

    for i in (seq 1 $steps)
        set curr (eval $getsetfunc (math $curr - $each) print)
        debug $curr
        sleep $wait
    end
end
