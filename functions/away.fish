function away
    pmset displaysleepnow
    pauseall
    t screen off
    set -U volume_before_away (volume)
    volume_ramp 0
    spotify pause
    t speakers off
    milight 5
    milight c 200 2


    #fish -c 'cpulimit iTerm2 5' &
end
