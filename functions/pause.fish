function pause
	for app in $argv
        pkill -STOP $app
        and echo (tint: bryellow "paused") \t (tint: purple $app)
    end
end
