function brew-search
test -z "$argv"
and return 1

tput civis
test (string length -- $argv) -gt 2 #messy if desc search for just 1-2 letters
and set output (brew search --desc $argv | grep $argv)
or set output (brew search --desc $argv | grep \ $argv)

set hitcount (count $output)
test "$hitcount" -eq 0
and tput cnorm
and return 1

for i in (seq 1 $hitcount)
set brews[$i] (string split ":" -- $output[$i])[1]
set descs[$i] (string split ":" -- $output[$i])[2]
debug "brew: %s  desc: %s" $brews[$i] $descs[$i]
end
set -l len_b 1
set -l len_d 1
for b in $brews
test (string length -- $b) -gt $len_b
and set len_b (string length -- $b)
end
echo $len_b | read longbrew
for d in $descs
test (string length -- $d) -gt $len_d
and set len_d (string length -- $d)
end
echo $len_d | read longdesc
#set longbrew (for b in $brews; test (string length -- $b) -gt $lenb; and set lenb (string length -- $b); end; echo $lenb)
#set longdesc (for d in $descs; test (string length -- $d) -gt $lend; and set lend (string length -- $d); end; echo $lend)
debug "brews max len %s %s  desc max len %s %s" $lenbrew $longbrew $lendesc $longdesc
#set urls (parallel --keep-order -i 'fish -c echo (brew info {})[3]' -- $brews)
for i in (seq 1 $hitcount)
echo -s (echo $brews[$i] | hilight $argv) (tput hpa $longbrew) (set_color purple) (echo $descs[$i] | hilight $argv)
end
tput cuu $hitcount
for i in (seq 1 $hitcount)
set urls[$i] (echo (brew info $brews[$i])[3])
echo -s (tput hpa (math (tput cols)-(string length -- $urls[$i])) ) (set_color brgreen) $urls[$i] (set_color normal)

end
tput cnorm
#for i in (seq 1 $amount) #tput hpa (math $lenbrew + $lendesc + 4) #set urls[$i] (echo (brew info $brews[$i])[3]) #echo -s (set_color brgreen) $urls[$i] | grep_hilight $argv #end
end
