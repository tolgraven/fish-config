function lnav
if test -z "$argv"
##and psc tmux >/dev/null
#if tmux has -t lnav ^&-
#debug "attaching to tmux"
#itermprofileswitch "tmux attach -t lnav ^&-" standard
#else
#debug "creating new tmux lnav session.."
#itermprofileswitch "tmux new -s lnav fish -c 'command lnav'" lnav
#end

#itermprofileswitch "tmux new -A -s 'lnav' -d fish -c 'command lnav'"  # -A = attach if already exists
profile lnav
#itermprofileswitch "tmux new -A -s 'lnav'" lnav "-d fish -c 'profile lnav; command lnav '"
#and tmux set -t "lnav" mouse off
#and tmux attach -t lnav
set -lx TERM screen-256color
command lnav $argv #lnav completely broken in newer tmux with 24bit color. and cant toggle that per session, only server :/
profile reset
else
debug "vanilla lnav.."
command lnav $argv
end
end
