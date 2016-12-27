function live
	if not test (pgrep Live)
        and not test $argv[1] = "clean"
        set -l live "/Applications/Ableton\ Live\ 9.7\ Beta.app/Contents/MacOS/Live"
        #open -a "Ableton Live 9 Suite"
        #and echo "opening Live"; set lives (ls /Applications/Ableton*); and echo $lives
        eval "$live" &
        sleep 0.2
        live
        #open -a $argv
        #or echo "ain't no live"
    else
        for app in $appsforliverenice
            if pgrep $app >/dev/null
                sudo -n renice -18 -p (pgrep $app)
                and echo (tint: red "aint nice   ") (tint: purple $app)
            end
        end
        for off in $appsforlivefuckoff
            if pgrep $off >/dev/null
                sudo -n renice 9 -p (pgrep $off)
                #cpulimit $off 20
                and echo (tint: green "  is nice   ") (tint: purple $off)
            end
        end
    end

    pkill Activity

    #await -
end
