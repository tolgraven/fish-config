function thumbnail
	test -z "$argv"
    and set argv (ls *.png *.jpg *.jpeg *.gif *.bmp *.tga *.tiff)

    set -l size '50%'
    imgcat -p --width=$size $argv #-p preserve aspect ratio
end
