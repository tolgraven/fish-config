function fordo --description 'for all in this do that' --argument this
	echo "dunn work so well lol didnt think this through need like tokens for most stuff but then meh xargs?"
    for result in (eval $this)
        #set j 2
        #while test $j -le (count $argv)
        for action in $argv[2..-1]
            echo (tint: red (bold: $action)) (tint: green $result)
            eval "$action" '$result'


            #echo (tint: blue $argv[$j]) (tint: green $i)
            #eval (echo $argv[$j] $i)
            #set j $j+1
        end
        echo
    end
end
