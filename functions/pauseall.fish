function pauseall
	for app in $appstopause

pause $app
#and echo "paused $app"
end
#cpulimit iTerm2 10
pkill "Activity Monitor"
end
