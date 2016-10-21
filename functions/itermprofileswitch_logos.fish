function itermprofileswitch_logos --argument from to size arrow itermdir
	if test -z $from
        or test -z $to
        return 1
    else if test $from = $to
        return 1
    end
    set -q $itermdir
    and set itermdir ~/.iterm2/
    test -z $size
    and set size 128
    set -l from_img $itermdir/profiles/$from/$from-$size.png
    set -l to_img $itermdir/profiles/$to/$to-$size.png
    if not test -e $from_img
        or not test -e $to_img
        or test -e $itermdir/profiles/$from/nologo
        or test -e $itermdir/profiles/$to/nologo
        return 1
    end
    test -z $arrow
    and set arrow $itermdir/profiles/ForwardArrowIcon-$size.png
    tput civis
    profile standard #for uniform spacing

    imgcat $from_img
    tput hpa 25
    move_back_lines 8
    sleep 0.1
    imgcat $arrow
    tput hpa 50
    move_back_lines 8
    sleep 0.1
    imgcat $to_img

    profile reset
    tput cnorm
end
