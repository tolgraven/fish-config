function audiohijack --argument command session
	set ah "Audio Hijack"
    test -z $session
    and set session "sonarworks-headphone-subpac-split" #for now
    test -z $command
    and set command "toggle"
    pgrep "Audio Hijack"
    or open -a "Audio Hijack"

    switch $command
        case "start"
            echo "do starty stuff"
            cont $ah
            rnice -10 $ah
        case "stop"
            echo "do stoppy stuff"
            rnice 0 $ah
            #stop session...
            #check for other running sessions?
            pause $ah
        case "list"
            osascript -e "tell application 'System Events' to tell process 'Audio Hijack' to 'UI Elements'"
        case "toggle"
            test audioswitch = "Balance"
            and audioswitch -s Soundflower\ \(2ch\)
            or audioswitch -s Balance
            osascript ~/Documents/CODE/OSX/scripts/audiohijack.applescript
            #osascript -e "tell application 'System Events' to tell process 'Audio Hijack' to click checkbox 'Run' of window $session"
    end

    #set window (GetWindowID "Audio Hijack" $session)
    #osascript -e "tell application 'Audio Hijack' to activate"
    #osascript -e "tell application 'System Events' to keystroke 'r' using command down"
end
