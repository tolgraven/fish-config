function imgcat -d 'tol custom imgcat, in conf.d so not overwritten' --argument imgfile height
    not test -z "$height"
    and set height ";height=$height"

    printf "\033]1337;File=inline=1;width=100%%$height;preserveAspectRatio=1"
    printf ":"
    base64 <"$imgfile"
    printf '\a\n'
end
