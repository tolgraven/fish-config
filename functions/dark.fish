function dark
	set commands "milight 5" "brightness 0" "contrast 25"
    run $commands
    return

    for each in $commands
        fish -c "$each" >/dev/null &
        #fish -c 'milight 5' &
        #fish -c "brightness 0" >/dev/null &
        sleep 0.01
        #fish -c "contrast 25" >/dev/null &
    end
end
