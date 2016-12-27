function volume_ramp --description 'smoothly change volume' --argument vol time steps
	ramp $vol volume $time $steps #use the generic func..
    and return $status

    test -z "$vol"
    and return
    test -z "$time"
    and set -l time 1 #0.3
    test -z "$steps"
    and set -l steps 10

    set -l curr (volume)
    set -l diff (math $curr-$vol)
    test $diff -gt 0
    and test $steps -gt $diff
    and set steps $diff
    #test $steps -lt 0
    #and set steps (math "0-$steps")

    set -l each (math -s2 "$diff / $steps")
    test $each -eq 0
    and set each 1
    set -l wait (math -s2 "$time / $steps")

    debug "curr %s vol %s diff %s steps %s each %s wait %s" $curr $vol $diff $steps $each $wait

    for i in (seq 1 $steps)
        set curr (volume (math $curr - $each) print)
        debug $curr
        sleep $wait
    end
end
