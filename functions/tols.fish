function tols --description 'ls with icons'
	set iconsize "16x16"
    set bitdepth 32
    set cachedir ~/.cache/tols/filetypes
    test -d "$cachedir"
    or mkdir -p "$cachedir" #only support for curr dir at first...
    #echo $cachedir
    set caches (command ls)

    set output (command ls)
    for i in (seq 1 (count $output))
        # also needs to check differently for png and icns bc obv
        #set output[$i] (string escape $output[$i]) #no thats what was fucking me in the first place ffs, in extname

        if test -d "$output[$i]" #tho also check not equals .app or other container...
            set output[$i] "echo (imgcat $cachedir/directory.png) \"$output[$i]\""
            #\t\t (tint: blue "cached")
            continue
        end
        set cachedicon $cachedir/(extname $output[$i]).png
        if test -r $cachedicon
            set output[$i] "echo (imgcat $cachedicon) \"$output[$i]\""
            #\t\t (tint: green "cached")
            continue
        end
        set filename "$output[$i]"
        #echo $filename
        geticon -o "$cachedir"/(extname $output[$i]) "$output[$i]"
        set hit (icns2png -x --size=$iconsize --depth=$bitdepth --output="$cachedir" $cachedir/(extname $output[$i]).icns ^&-) ^&-
        #echo $hit
        set hit (echo $hit\n | grep " Saved " | string split " element to ")
        #echo $hit
        if not test (count $hit) -eq 0
            set hit (echo $hit[-1] | string trim -r -c .) ^&-
            #echo $hit\n
            and set output[$i] "echo (imgcat $hit) \"$output[$i]\""
            mv "$hit" $cachedir/(extname $filename).png
        else
            set output[$i] "echo '   ' \"$filename\""
        end
        rm -rf "$cachedir"/*.icns
    end
    eval $output\n
end
