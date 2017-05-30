function brightness --argument newbrightness
test -z "$argv"
and set output (ddcctl -d 1 -b \? | string sub --start=-13 --length=3)[-1]
or switch "$newbrightness"
case 'refresh' 'reset'
brightness (brightness) >/dev/null
case '*+' '*-'
brightness (math (brightness) (string sub -s -1 -- $argv[1]) (string sub -l (math (string length -- $argv[1]) - 1) -- $argv[1]) )
return
case '+*' '-*'
brightness (math (brightness) (string sub -l 1 -- $argv[1]) (string sub -s 2 -- $argv[1]) )
return
case '*'
if isint $newbrightness
test $newbrightness -gt 100
and set newbrightness 100
test $newbrightness -lt 0
and set newbrightness 0
else
return 1
end
set output (ddcctl -d 1 -b $newbrightness | string sub -s -3)[-1]
and ddcctl -d 2 -b $newbrightness >&-
end
set -U brightness_main (string replace -r --all -- '>|:' '' $output | string trim)
echo $brightness_main
end
