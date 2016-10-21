function milight --description 'change milight via hammerspoon' --argument thing val zone
	test "$thing" -gt 0
    and set val $thing
    and set -e thing
    if test -z "$thing"
        set thing b
    end
    if test -z "$val"
        set val ""
    else
        test "$val" -gt 0
        and set val " , $val"
    end
    test -z "$zone"
    and set zone 0
    switch "$thing"
        case 'b*' 'B*'
            set thing Brightness #then also +/-...
        case 'm*' 'M*' #max
            milight b 25
            return
        case 'wf' 'WF' #white full
            milight w
            sleep 0.1
            milight m
            return
        case 'w*' 'W*'
            set thing White
        case 'c*' 'C*'
            set thing Color
        case 'on' 'ON' 'n'
            set thing On
        case 'off' 'OFF' 'f' '0'
            set thing Off
        case 't*' 'T*' 'toggle' #get status from openhab i guess?...
    end

    set -l retries 5
    for i in (seq 1 $retries)
        hs "mi:zone$thing($zone$val)" ^&-
        sleep 0.1
    end
end
