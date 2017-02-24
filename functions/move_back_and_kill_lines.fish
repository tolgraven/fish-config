function move_back_and_kill_lines --argument lines time
test -z $time
and set time 0
test -z $lines
and set lines 1
set perline (math -s2 "$time / $lines")
test -z (string replace -- '.' '' $perline)
and set -e perline

tput civis
for i in (seq 1 $lines)
set -q perline
and sleep $perline #put before the rest so less jerky when finishing...

tput el
tput cuu1
end
tput cnorm
end
