function __tols_addicon --argument dirname item label iconsize bitdepth cachedir
	debug "fetching %s" $item #DEPS: brew osxutils, icns2png, (prob convert also later. and parallel/env_parallel)
    test (count $argv) -gt 0
    or return 1
    test -z "$iconsize"
    and set iconsize "16x16"
    test -z "$bitdepth"
    set bitdepth 32
    test -z "$cachedir"
    and set cachedir ~/.cache/tols/filetypes
    test -d "$cachedir"
    or mkdir -p "$cachedir"

    #test -z "$spaces"; and set spaces '  '
    set -l fullpath $dirname/"$item"
    set -l cachedicon $cachedir/(extname $item).png
    set -l symbol

    switch (extname $item) #test (extname $item) = "app"
        case "app"
            set cachedicon $cachedir/apps/(basename $item)-app.png
            set -l app (basename $item)
            debug "Got app $app"
        case 'conf*' 'cfg' '*rc' '*profile' '*env*' '*shell*'
            set symbol ⚙
        case 'md' 'txt' 'rtf' 'README' 'LICENSE' 'log'
            set symbol 📰 #📖
        case 'ssh' '*rsa*' 'id*' '*key*' '*cert*'
            set symbol 🔑
        case '*drive*' 'Volume*' '*mount*' '*mnt*' '*back*' '*bak*' '*BAK*'
            set symbol 💾
        case '*'
            set symbol 📄
    end
    if test -d "$fullpath" # dir
        and not set -q app
        if test -r "$fullpath" #not test -L "$fullpath" #if not symlink..
            set kind (get_label "$fullpath")
            set icon __tols_folder_$kind #(get_label "$fullpath") #(imgcat $cachedir/directory_(get_label "$fullpath")_$iconsize.png) #dir
            set icon (echo $$icon)
            test -z "$icon"
            and set icon $e_folder[1]
            #else ### TODO: make symlink versions with an arrow on it... skip right now put by link
            #set icon $emojis_nonshitty[6] #rocketlol  #(imgcat $cachedir/directory_(get_label "$fullpath")_$iconsize.png)
        end
        switch (extname $item)
            case "vst" "bundle" "component"
                set icon $emojis_nonshitty[3] #piano (imgcat $cachedir/(extname $item).png)
        end
        echo -ns "$icon " #(tput cub 1)
        debug "did fetch CACHED DIR icon-emoji for %s" $item
        return 0
    else if not test -z "$symbol" # preped emoji
        echo -ns "$symbol "
        debug "did fetch PREPARED EMOJI"
        return 0
    else if test -r "$cachedicon" # readable cached file
        set icon (imgcat $cachedicon)
        echo -ns $icon (tput cub 1)
        debug "did fetch CACHED icon-icon for %s" $item
        return 0
    else if test (string sub -l 1 -- $item) = '.' # dotfile
        set icon $emojis_nonshitty[-1] #spiderweb #$emojis_nonshitty[15] #checkmark #floppy #"$spaces"
        echo -n "$icon "
        debug "did fetch CACHED space-not-icon for %s" $item
        return 0
    end
    debug "no cache hit for %s" $item
    if set -q app
        geticon -o "$cachedir"/apps/$app-app "$fullpath" ^&-
    else
        geticon -o "$cachedir"/(extname $item) "$fullpath" ^&-
    end #or echo -n -s "WRONG"

    set hit (icns2png -x --size=$iconsize --depth=$bitdepth --output="$cachedir" $cachedir/(set -q app; and echo apps/$app-; or echo "")(extname $item).icns ^&-) ^&-
    set hit (echo $hit\n | grep " Saved " | string split " element to ")

    if not test (count $hit) -eq 0
        set hit (echo $hit[-1] | string trim -r -c .) ^&-
        and set icon (imgcat "$hit")
        mv "$hit" $cachedir/(set -q app; and echo apps/$app-; or echo "")(extname $item).png ^&-
    else
        set icon $emojis_nonshitty[1] "$spaces" #needs to vary with font and shit tho... ugh
    end
    trash "$cachedir"/(extname $item).icns ^&-
    debug "did fetch NEW UNCACHED icon for %s" $item
    echo -n "$icon " #(tput cub 1)
end
