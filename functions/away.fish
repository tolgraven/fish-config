function away --description 'away from computer' --argument how
    #TODO: something like "deactivate Live audio engine before pause, if Live is running" 
    #else audio gets fucked...

    pmset displaysleepnow
    pauseall
    t screen off

    switch "$how"
        case 'out' #only kill audio etc if actually going out, 
            set -U volume_before_away (volume)
            volume_ramp 0
            spotify pause #actually should transfer spotify to phone if its playing. how?
        case 'sleep'

        case '*'

    end
    t speakers off
    t light-therapy off
    t ltb off

    milight 5
    milight c 200 2

    #fish -c 'cpulimit iTerm2 5' &
end
