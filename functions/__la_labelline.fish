function __la_labelline --argument dirname item line
	set fullpath $dirname/"$item"
    if test -d $fullpath
        set label (get_label "$fullpath" ^&-) #absolutely should parallelize this! would be hella faster...
        test $label = 'None'
        and set label 'normal'
        #echo $label
    else
        echo $line
        return 0
    end
    test $label = 'normal'
    and switch $item
        case bin exec Applications MacOS
            set label "brred"
        case "*lib" "lib*" src include headers node python "function*"
            set label "purple"
        case "*.vst" "*.component" "ableton*"
            set label "green"
    end
    set relevantpart (string split -r -m 2 . "$item")[1]
    test -z $relevantpart
    and set relevantpart (string sub -s 2 "$item") #reset filepart to entire file if dotfile
    #echo $relevantpart
    echo (string replace "$relevantpart" (set_color $label)"$relevantpart"(set_color normal) "$line" ^&-) ^&-
end
