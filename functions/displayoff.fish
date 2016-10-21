function displayoff
	pmset displaysleepnow
    sleep 1
    ddcctl -d 1 -p 5
    ddcctl -d 2 -p 5
end
