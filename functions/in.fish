function in --argument minutes do
	echo "will do " (tint: blue $do) " in" (tint: red $minutes) "minutes -" (tint: gray (math "$minutes*60")) "seconds"
    sleep (math "$minutes*60")
    eval $do
end
