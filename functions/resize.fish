function resize
	echo $argv[1] -resize $argv[2]% (string split . $argv[1])[1]-resized.(string split . $argv[1])[2]
end
