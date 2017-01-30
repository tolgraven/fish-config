function pauseall
for app in $appstopause
rnice 1 $app #tag so easy to spot in htop
pause $app
#and echo "paused $app"
end
#cpulimit iTerm2 10
pkill "Activity Monitor"
k "MidiAutomapClient" >&- ^&- #bc doesnt pause
end
