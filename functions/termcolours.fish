function termcolours
	for color in (__termcolours)
        echo -n -s $color \t \t
    end #| pr --columns=4 -t -w100
end
