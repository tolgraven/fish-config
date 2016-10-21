function t --argument device state host
	switch $device
        case 'sp' 's'
            set device "speakers"
        case 'lt' 'light'
            set device "light-therapy"
        case 'ltb' 'bed'
            set device "light-therapy_bedroom"
        case 'sc'
            set device "screen"
        case 'sb'
            set device "sub"
    end
    toggle_telldus $device $state $host
end
