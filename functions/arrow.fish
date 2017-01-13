function arrow --argument direction color fgcolor text
    #test -z "$direction"
    if not test "$direction" = "left" -o "$direction" = "right"
        set color $direction
        set direction "right"
    end
    test -z "$color"
    and set color "red"
    test -z "$fgcolor"
    and set fgcolor "black"

    test -z "$text"
    and set text ""

    if test "$direction" = "right"
        set symbol ''
        #set cmd "segment"
    else
        set symbol ''
        #set cmd "segment_right"
    end

    echo (set_color -b $fgcolor $color)$symbol(set_color normal)
    #eval $cmd $fgcolor $color "$text"
    #segment_close
end
