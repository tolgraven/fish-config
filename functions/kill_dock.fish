function kill_dock
	pkill Dock
    sleep 1
    open -a HyperDock #doesnt restart automatically...
end
