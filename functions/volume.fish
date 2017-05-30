function volume --description 'get/set audio volume' --argument newvolume printnew
if test -z "$newvolume" #blank = print
osascript -e "output volume of (get volume settings)" | grep -o --color=never "[0-9][0-9]*" #[0-9]" #last one stops <10 from working. side effects?
else if test "$newvolume" = "state"
echo -s (volume) (osascript -e 'output muted of (get volume settings)' | string replace 'true' ' (muted)' | string replace 'false' '')
else if test "$newvolume" = "mute"
set -l state (osascript -e 'output muted of (get volume settings)')
test "$state" = "true"
and set state "false"
or set state "true"
osascript -e "set volume output muted $state"
else
set scale 0.07
set transform (math -s2 "$newvolume * $scale")
math "$transform < 0"
and set transform 0
test "$transform" -gt (math "100 * $scale")
and set transform (math "100 * $scale")

debug "newvolume %s transform %s" $newvolume $transform

osascript -e "set volume $transform" >&- ^&-
set stat $status
not test -z "$printnew"
and volume

return $stat
end
end
