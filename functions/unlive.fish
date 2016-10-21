function unlive
	for app in $appsforliverenice $appsforlivefuckoff
        sudo -n renice 0 -p (pgrep $app)
        and echo (tint: blue "is normal   ") (tint: purple $app)
    end
end
