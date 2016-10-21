function brightness_ramp --argument newbrightness direction
	#echo "Current: " (brightness)

    test -z $direction
    or set newbrightness (math "$brightness_main $direction $newbrightness")
    test $newbrightness -gt 100
    and set newbrightness 100
    test $newbrightness -lt 0
    and set newbrightness 0
    #echo "New:     " $newbrightness

    set diff (math "$brightness_main - $newbrightness")
    test $diff -eq 0
    and return 1
    set granularity (math "scale=0; $diff / 10")
    if test $granularity -lt 0
        set granularity (math "$granularity * -1")
        set direction '+'
    else
        set direction '-'
    end
    test $granularity -lt 4
    and ++ granularity
    test $granularity -gt 7
    and set granularity 7
    #echo "Steps of:" $granularity

    set -g counter $granularity
    #echo (seq (math "$brightness_main $relativesign $granularity") $newbrightness)
    for i in (seq (math "$brightness_main $direction $granularity") $newbrightness)
        test $counter -eq $granularity
        #and tint: blue "hit"
        and brightness $i >/dev/null

        set counter (math "$counter -1")

        #echo $counter
        test $counter -le 0
        and set counter $granularity
    end
    test $brightness_main -ne $newbrightness
    and brightness $newbrightness >/dev/null
end
