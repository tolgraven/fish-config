function osae
	#osascript -e (string escape "$argv")
    echo (string replace \" \\\" $argv)
end
