function dock_add_separator
	defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
    and
    killall Dock
end
