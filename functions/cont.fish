function cont
	for app in $argv
        pkill -CONT $app
        and echo (tint: blue "resumed") \t (tint: purple $app)
    end
end
