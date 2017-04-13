function volume --description 'get/set audio volume' --argument newvolume printnew
if test -z "$newvolume" #blank = print
osascript -e "output volume of (get volume settings)" | grep -o --color=never "[0-9][0-9]*" #[0-9]" #last one stops <10 from working. side effects?
else
set scale 0.07
set transform (math -s2 "$newvolume * $scale")
#test "$transform" -lt 0
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
