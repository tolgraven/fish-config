function milight --description 'change milight via hammerspoon' --argument thing val zone bridge
isint $thing
and set val $thing #if just passing a nr
and set thing "b"
if not test -z "$val"
if test "$val" -gt 3
and string match -q -- 'b*' "$thing" #test "$thing" = 'b*' #'c*'
set val (math "$val / 4") #only 25 steps to milight. conf in hs tho
end
set val " , $val"
else #then grab rel colors from openhab or w/e?
end
test -z "$zone"
and set zone 0 #0 is all zones
test -z "$bridge"
and set -l bridge "mi" #"mipi"
switch "$thing"
case 'b*' 'B*'
set thing "Brightness" #then also +/-...
case 'm*' 'M*' #max
milight brightness 100 $zone #25
return
case 'wf' 'WF' 'wm' 'WM' #white full
milight white $zone
spin "sleep 0.2"
milight brightness 100 $zone
return
case 'wl' 'WL' 'W0' 'w0' #white low
milight w $zone
spin "sleep 0.2"
milight brightness 1 $zone
return
case 'w*' 'W*'
set thing White
case 'cf' 'CF' 'cm' 'CM' #color maxed
milight c $val $zone
spin "sleep 0.2"
milight brightness 100 $zone
return
case 'cl' 'CL' 'c0' 'C0' #color low
milight c $val $zone
spin "sleep 0.2"
milight brightness 1 $zone
return
case 'c*' 'C*'
set thing Color
case 'on' 'ON' '*n'
set thing On
case 'off' 'OFF' '*f*' '0'
set thing Off
case 't*' 'T*' 'toggle' #get status from openhab i guess?...
end
fish -c "for i in (seq 1 3)
           hs '$bridge:zone$thing($zone$val)' ^&- >&- & 
           sleep 0.085 #25 #was actually acting a bitch at 0.1 ugh
         end" &
end
