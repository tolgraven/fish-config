function svg_to_png --argument svg png w h
	test -z $w
    and set w 1024
    test -z $h
    or set h "-h $h"
    inkscape -z -e $png -w $w $h $svg
end
