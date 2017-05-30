function contrast
not test -z "$argv[1]"
and switch "$argv[1]"
case '*+' '*-'
contrast (math (contrast) (string sub -s -1 -- $argv[1]) (string sub -l (math (string length -- $argv[1]) - 1) -- $argv[1]) )
return
case '+*' '-*'
contrast (math (contrast) (string sub -l 1 -- $argv[1]) (string sub -s 2 -- $argv[1]) )
return
case '*'
set -U contrast_unscaled $argv[1]
set scaled (math "$contrast_unscaled / 1.42")
set asus (math "$scaled / 1.9 + 15")
set output (ddcctl -d 1 -c $scaled | string sub -s -3)[-1]
ddcctl -d 2 -c $asus >/dev/null
end
or set -q contrast_unscaled
and echo $contrast_unscaled
or begin
set output[1] (ddcctl -d 1 -c \? | string sub --start=-13 --length=3)[-1]
string replace -- '>' '' $output | string trim
end
end
