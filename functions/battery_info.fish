function battery_info
	battery.info.update
    echo -s $BATTERY_PCT "% remaining"
    echo $BATTERY_TIME_LEFT "h left"
    battery
end
