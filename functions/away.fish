function away
	pauseall
    sleep 1
    #displayoff
    ssh paj "tdtool --off screen"
    pmset displaysleepnow
    #tdtool lala turn off speakers et al. or well send cmd w ssh or mqtt
end
