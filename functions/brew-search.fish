function brew-search --description 'search brew, but fancy'
test (string length -- $argv) -gt 3 #messy if desc search for just 1-2 letters
and set output (brew search --desc $argv | grep $argv)
or set output (brew search --desc $argv | grep \ $argv)

set hitcount (count $output)
if test "$hitcount" -eq 0
return 1
else if test "$hitcount" -gt $LINES
set hitcount $LINES
set output $output[1..$hitcount] #cap to screen length
end

for i in (seq 1 $hitcount)
set brews[$i] (string split ":" -- $output[$i])[1]
set descs[$i] (string split ":" -- $output[$i])[2]
debug "brew: %s  desc: %s" $brews[$i] $descs[$i]
end
set -l info (brew info $brews --json=v1)
set -l urls (echo $info | jq 'map(.homepage)[]' | string replace --all \" '')
set -l installed (echo $info | jq 'map(.installed)[] | length' | string replace --all '1' (set_color --bold green)' ✔'(set_color normal) | string replace --all '0' '')
#
for b in $brews
test (string length -- $b) -gt (not test -z "$longbrew"; and echo $longbrew; or echo 1)
and set longbrew (string length -- $b)
end
for d in $descs
test (string length -- $d) -gt (not test -z "$longdesc"; and echo $longdesc; or echo 1)
and set longdesc (string length -- $d)
end
debug "brews max len %s %s  desc max len %s %s" $lenbrew $longbrew $lendesc $longdesc

tput civis
for i in (seq 1 $hitcount)
echo -ns (echo $brews[$i] | hilight $argv) $installed[$i] (tput hpa $longbrew) (set_color purple) (echo $descs[$i] | hilight $argv)
echo -s (tput hpa (math (tput cols)-(string length -- $urls[$i])) ) (set_color brgreen) $urls[$i] (set_color normal)
end

tput cnorm
end
