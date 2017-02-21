function hue --description 'imagemagick modulate hue' --argument input hue output
#"However be warned that the hue is rotated using a percentage, and not by an angle
#This may seem weird but "-modulate" has always been that way."
set hue_magick (math "($hue * 100/180) + 100")
#imgcat $input
convert $input -modulate 100,100,$hue $output
echo
imgcat $output
end
