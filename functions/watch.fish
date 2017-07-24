# Defined in /Users/tolgraven/.config/fish/functions/watch.fish @ line 2
function watch --description 'watch a cmd, or (with no args) files in current dir'
bind \cq "set -g watch_exit true" #; commandline -f execute"
tput civis
tput smcup
set -l lastoutput
bind q "set -g watch_exit; echo Q PUSHEDDD"
not set -q watchcmd
and set watchcmd "du -h (ls -tr) | tail -$LINES | cut -c -(math (tput cols) - 2)"
while not set -q watch_exit
set output (eval $watchcmd)
if not string match $output $lastoutput
clear
echo -sn $output\n
#echo \e\[0J #wat is??
end
sleep 2
set lastoutput $output
end
set -e watch_exit
tol_reload_key_bindings
tput cnorm
tput rmcup
echo -ns $lastoutput\n
end
