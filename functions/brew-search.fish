function brew-search
	test -z "$argv"
    and return 1

    tput civis

    if test (string length -- $argv) -gt 2
        set output (spin "brew search --desc $argv | grep $argv")
    else
        set output (spin "brew search --desc $argv | grep \ $argv") #gets messy with full desc search for just two letters
    end
    set hitcount (count $output)
    test "$hitcount" -eq 0
    and tput cnorm
    and return 1

    for i in (seq 1 $hitcount)
        set brews[$i] (string split ":" -- $output[$i])[1]
        set descs[$i] (string split ":" -- $output[$i])[2]
        debug "brew: %s  desc: %s" $brews[$i] $descs[$i]
    end

    set longestbrew (for brew in $brews; test (string length -- $brew) -gt "$lenbrew"; and set lenbrew (string length -- $brew); end; echo $lenbrew)
    set longestdesc (for desc in $descs; test (string length -- $desc) -gt "$lendesc"; and set lendesc (string length -- $desc); end; echo $lendesc)
    debug "brews max len %s %s   desc max len %s %s" $lenbrew $longestbrew $lendesc $longestdesc

    #set urls (parallel --keep-order -i 'fish -c echo (brew info {})[3]' -- $brews)
    for i in (seq 1 $hitcount)
        set urls[$i] (echo (brew info $brews[$i])[3])
        echo -s (echo $brews[$i] | hilight $argv) (tput hpa $longestbrew) (set_color purple) (echo $descs[$i] | hilight $argv) (tput hpa (math (tput cols) - (string length -- $urls[$i]) ) ) $urls[$i]
        #echo -s (tput cuu1) #(tput hpa 0) #echoright $urls[$i] #echoright (echo -s (set_color brgreen) $urls[$i] (set_color normal) ) #| hilight $argv) #tput cuu1
    end
    tput cnorm
    #for i in (seq 1 $amount) #tput hpa (math $lenbrew + $lendesc + 4) #set urls[$i] (echo (brew info $brews[$i])[3]) #echo -s (set_color brgreen) $urls[$i] | grep_hilight $argv #end
end
