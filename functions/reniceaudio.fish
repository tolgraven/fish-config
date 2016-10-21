function reniceaudio
	for app in $appsforliverenice
        if pgrep $app >/dev/null
            sudo -n renice -15 -p (pgrep $app)
            and echo (tint: red "aint nice   ") (tint: purple $app)
        end
    end
end
