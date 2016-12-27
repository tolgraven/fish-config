function bright
	set commands "milight 100" "brightness 100" "contrast 90"
    run $commands
    return

    fish -c 'brightness 100' >/dev/null &
    #sleep 0.1
    fish -c 'contrast 90' >/dev/null &
    milight 100
end
