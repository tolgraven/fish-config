function volumes
	command -s grc >/dev/null
    and set cmd "grc --colour=on df -Ph $argv" # P posix no inode, h human
    or set cmd "df -Ph $argv"
    echo (eval $cmd)[1]
    eval $cmd | string replace "/Volumes/" (set_color red)"/V/"(set_color normal) | string replace "$HOME" "~" | sort | grep -v "Filesystem" | grep -v devfs | grep -v map | grep -v MobileBackups
end
