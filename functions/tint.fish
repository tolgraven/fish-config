function tint --description 'highlight word/phrase in text using color' --argument thing color restoredcolor string
	#test -z "$string" #prob being piped then
    #test -z "$restorecolor"
    #and set restorecolor normal
    while read line
        string replace --all -- "$thing" (set_color $color)"$thing"(set_color normal) #(not test -z "$restoredcolor"; and echo $restoredcolor; or echo "normal"))
    end
    #(test (count $argv) -gt 3; and echo -ns $argv[4..-1]\n)
end
