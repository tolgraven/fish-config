function fish_greeting
	if test $SHLVL -gt 1
        or not isatty 1
        or not status --is-interactive
        return 0
    end
    tput smcup
    tput civis
    not test -z "$iterm2_hostname"
    #or
    and not test -z "$ITERM_PROFILE"
    and switch (hostname) #$iterm2_hostname
        case "absurd"
            imgcat ~/.config/tols/com.apple.macpro-cylinder_512x512x32.png
            move_back_and_kill_lines 4 0
        case "thenewpro"
            imgcat ~/.config/tols/com.apple.macbookpro-15-retina-display_512x512x32.png
            move_back_and_kill_lines 7 0
        case 'paj'
            imgcat ~/.iterm2/raspberry-pi-logo-small.png
        case "paj" imgcat ~/.iterm2/raspberry-pi-logo-small.png move_back_and_kill_lines 5 0
    end
    echo -n "R.I.P Steve Jobs (pbuh). "
    echo -n "Praise Jony 'fucking' Ive (pbuh)"

    for i in (seq 1 25) #get height tho...
        tput dl1 #clear whole line?
        tput cuu1
        tput hpa 0
        echo -n "R.I.P Steve Jobs (pbuh). "
        tput hpa (math "26+$i*2") #set only horizontal pos
        echo -n "Praise Jony 'fucking' Ive (pbuh)"
        sleep 0.0075
    end
    tput cnorm
    tput rmcup
end
