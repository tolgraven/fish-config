function termcolours --argument cols
#test -z "$cols"
#and set cols 5
#__termcolours | gpr --columns=$cols -t --page-width 180 --width 180 #--across #100
clear
set -l i 1
set -l col_off 0

__termcolours | string replace 'colour' (tput smso)'   '(tput rmso) | while read line
echo -s (tput hpa $col_off) $line

set i (math $i+1)

test $i -gt 16
and tput cuu (math $i - 1)
and set col_off (math $col_off + 7)
and set i 1

end
tput vpa 16
end
