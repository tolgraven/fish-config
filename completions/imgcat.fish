#for npm imgcat-cli
complete -c imgcat -s h -l help -d "Show usage help"
complete -c imgcat -l width -a "(echo N\tcharacter cells\nNpx\tNpixels\nN%\tNpercent of session\nauto\tduh)" -fr
complete -c imgcat -l height -a "(echo N\tcharacter cells\nNpx\tNpixels\nN%\tNpercent of session\nauto\tduh)" -fr
complete -c imgcat -l preserveAspectRatio -a "(echo true\tdefault\nfalse\tsquash)" -fr
