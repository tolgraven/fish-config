function toggle_telldus --description 'toggle tdtool on paj or w/e' --argument device state host
	test -z $state
    and set state toggle
    test -z $host
    and set host "paj"
    switch $state
        case 'on'
            ssh $host "tdtool -n $device"
        case 'off'
            ssh $host "tdtool -f $device"
        case 'toggle'
            set currstate (ssh $host "echo (tdtool -l | grep "$device")[1]" | string split \t)[-1]
            switch $currstate
                case 'ON'
                    toggle_telldus "$device" 'off' $host
                case 'OFF'
                    toggle_telldus "$device" 'on' $host
            end
    end
end
