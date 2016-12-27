function bluetooth --argument state
	not test -z $state
    and switch $state
        case 'on'
            sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 1
        case 'off'
            sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 0
            and sudo killall -HUP blued
    end
end
