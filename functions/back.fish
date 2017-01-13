function back
    t screen on
    contall
    caffeinate -u -d -t 1 & #wake screen
    t speakers on #how avoid turning on sub auto?

    set -q volume_before_away #check so dont nil volume if double triggered
    and volume_ramp $volume_before_away #restore volume level
    set -e volume_before_away
    #resound #no need w new sound card!! :D

    #brightness (brightness) #brightness refresh #these fuck up and stall if the monitor isnt responding...
    #contrast (contrast)
    #sudo pkill cpulimit & #always lead to weird stuff
end
