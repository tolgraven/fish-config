function pauseformusic
	for app in $pauseformusic
        pause $app
        #and echo (tint: green "paused") \t (tint: purple $app)
        #or echo (tint: red "couldn't pause") \t (tint: purple $app)
    end
    pkill Activity
end
