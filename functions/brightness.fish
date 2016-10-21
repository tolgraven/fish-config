function brightness --argument newbrightness direction
	if test -z "$argv"
        set output (echo (ddcctl -d 1 -b \? | string sub --start=-13 --length=3)[-1])
    else if test $newbrightness = "refresh"
        or test $newbrightness = "reset"
        brightness (brightness) >/dev/null
    else
        test -z $direction
        or set newbrightness (math "$brightness_main $direction $newbrightness") # räcker skicka "5+" osv till skärmen behöver inte göra matten själv... fixa
        test $newbrightness -gt 100
        and set newbrightness 100
        test $newbrightness -lt 0
        and set newbrightness 0
        set output (echo (ddcctl -d 1 -b $newbrightness | string sub -s -3)[-1])
        and ddcctl -d 2 -b $newbrightness >&-
    end
    set -U brightness_main (echo $output | string replace ':' '' | string replace '>' '' | string trim)
    echo $brightness_main
end
