function getvolume
	osascript -e "output volume of (get volume settings)" | grep -o --color=never "[0-9][0-9]*[0-9]" #osascript ~/automation/getVolume.scpt ^ /dev/null | grep -o "[0-9][0-9]*[0-9]" # bc of annoying jack error msgs...
end
