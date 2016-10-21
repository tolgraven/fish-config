function __tols_labelline --argument dirname item line
	debug "getting label for %s" $item
    set fullpath $dirname/"$item"
    if test -d "$fullpath"
        and test -r "$fullpath"
        set label (get_label "$fullpath" ^&-) ^&- #absolutely should parallelize this! would be hella faster...
        debug "made get_label call for %s" $item
        #test "$label" = 'None'
        #and set label 'normal'
    else
        echo $line
        return 0
    end
    test "$label" = "None" #'normal'
    and switch "$item"
        case "*bin" "exec*" Applications MacOS '*osx*' '*brew*' 'cask*'
            set label "Orange" #"brred"
        case "*lib" "lib*" src include headers "node*" "python*" "function*" 'vim*' '*sublime*'
            set label "Purple"
        case "*.vst" "*.component" "ableton*"
            set label "Green"
        case "*git*" "*mnt*" "*ssh*" "*remote*" "*backup*" "*bak*"
            set label "Red"
    end
    set relevantpart (string split -r -m 2 -- . "$item")[1]
    test -z "$relevantpart"
    and set relevantpart (string sub -s 2 -- "$item") #reset filepart to entire file if dotfile
    #echo $relevantpart
    set -l labelindex (contains -i -- "$label" $label_colors)
    test "$labelindex" -gt 0 -a "$labelindex" -le 8
    and set label $label_colors_fish[ $labelindex ]
    or set label "normal"
    echo (string replace -- "$relevantpart" (set_color $label)"$relevantpart"(set_color normal) "$line")
    debug "done getting label for %s" $item
end
