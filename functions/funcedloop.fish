function funcedloop --argument function passedargs donteval -w func
test -z $function
and return 1
#yeah
set funcdir ~/.config/fish/functions
set funcfile $funcdir/$function.fish
set origdiff (mktemp)
cat funcfile >$origdiff
set tmpdiff (mktemp -t fish_"$function"_prev.XXXXXXXXXX.fish)
bind \cq 'set -g funcedloop_stop; and commandline -f execute' #why not working?
while not set -q funcedloop_stop #add a neater way to quit... so can set var like "editing" and warn if trying to edit a func from somewhere else
functions $function >$tmpdiff

func $function
#emit FUNC_SAVED $function
echo \n
if test -z $donteval
eval $function $passedargs #test output
else if set -q funcedloop_stop
break
else
continue
end
#set stat "Go fuck yourself." # $status
set stat $status
set curr (functions $function)

diff -w $tmpdiff $funcfile
echo -s \n (set_color bryellow) 'Time to eval: ' (set_color purple) $CMD_DURATION (set_color normal) ' ms'
echo -s "Status: " $stat \n
end
echo "YOU FINISHED!! Orig vs. final diff:"
diff -w $origdiff $funcfile
end
