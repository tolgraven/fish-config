function set_wallpaper --description 'set all (sadly) spaces desktop background' --argument png
	test -z "$png"
    and set png '/Users/tolgraven/Pictures/SYSTEM/desktops/Lake.png'
    sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = $png"
    killall Dock
end
