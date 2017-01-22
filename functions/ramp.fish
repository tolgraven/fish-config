function ramp --description 'smoothly change value' --argument newval getsetfunc time steps low_bound high_bound
    test -z "$newval"
    and return
    test -z "$time"
    and set -l time 1
    test -z "$steps"
    and set -l steps 20
    test -z "$low_bound"
    and set low_bound 0
    test -z "$high_bound"
    and set high_bound 100

    set -l curr (eval $getsetfunc)
    set -l diff (math $curr-$newval)
    if test "$diff" -gt 0
        test "$steps" -gt "$diff"
        and set steps $diff
    else if test "$diff" -lt 0
        test "$steps" -gt (math "0-$diff")
        and set steps (math "0-$diff")
    else #no change
        return
    end

    set -l each (math -s2 "$diff / $steps")
    test "$each" -eq 0
    and set each 1
    set -l wait (math -s2 "$time / $steps")

    debug "curr %s newval %s diff %s steps %s each %s wait %s" $curr $newval $diff $steps $each $wait

    for i in (seq 1 $steps)
        set was $curr
        set dest (math $curr - $each)
        if test "$dest" -gt $high_bound
            set dest $high_bound
        else if test "$dest" -lt $low_bound
            set dest $low_bound
        end
        set curr (eval $getsetfunc $dest print)
        debug "was %s, dest %s, curr %s" $was $curr $dest

        test "$curr" -eq "$dest"
        and break

        sleep "$wait"
    end
    eval $getsetfunc $newval #in case rounding has thrown it off
end
