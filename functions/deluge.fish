function deluge --description 'control deluge from fish commandline' --argument command argument
test -z "$command"
and set argv[1] "info"
set -l deluge 'deluge'
type --no-functions -q deluge
or set deluge "/Applications/Deluge.app/Contents/MacOS/deluge-console"
test "$command" = "p"
and set argv[1] "pause" #not pscc deluged >&- ^&-; and deluged #using launchctrl properly now
switch "$command"
case 'info' 'i'
set -l output (eval $deluge $argv | string trim | strip_empty_lines | grep -v "ID: " | string replace --all 'Name:' (set_color -o blue)''(tput smso) | hide 'State: ' 'Seeds: ' 'Size: ' 'Tracker status: ' 'Progress: ' ' Speed' ' time')
set output (echo -ns $output\n | string replace "Paused" (set_color -o -b brred black)"Paused " | string replace "Seeding Up:" (set_color -o -b green black)"Seeding "(set_color normal) | string replace "Downloading Down:" (set_color -o -b bryellow black)"Downloading " | string replace "Speed:" (tput smso)"Speed"(tput rmso) | string replace 'Up:' \t\t'Up:' | string replace 'Peers:' \t\t'Peers:' | string replace 'Active:' \t\t'Active:' | string replace 'Ratio:' \t\t'Ratio:' | string replace 'Availability:' \t'Avail:' | string replace 'Announce OK' \ \t\t'Announce OK' | string replace 'ETA:' \t(set_color -o -b brgreen)'ETA:'(set_color normal)) #gg
echo -ns $output\n | tint '#' brblue | tint 'Ratio' brpurple | tint 'Down:' bryellow | tint 'Up:' brgreen | tint 'GiB' green | tint 'MiB' red | tint 'KiB' brgrey | tint '/' brblue | tint '\[' blue | tint '\]' blue | tint '~' purple | tint 'Error:' red | tint '%' brpurple | tint 'Announce OK' brgreen | tint 'Peers:' brblue | tint 'Avail:' blue

case 'watch' 'w'
function __exit --on-job-exit %self --on-signal SIGINT
functions -e __exit
tput rmcup
tput cnorm
commandline -f repaint
end
tput civis
tput smcup
set -l refresh 3
while true
set output (deluge info) #refresh content _before_ clearing scr so ready to go
clear #tput smcup
echo -ns $output\n #tput vpa (math "$LINES - 2"); echo "press enter for command prompt"
sleep $refresh
end
case 'pb' 'c' 'clip' 'clipboard' 'm' 'magnet'
deluge add (string escape (pbpaste))
case 'console'
eval $deluge
case 'del' 'pause' 'recheck' 'resume' 'rm' 'add' 'help' '*'
eval $deluge $argv #eval $deluge (string escape "$argv") ^&-
end
end
