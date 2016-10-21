function tolmenu_cd
	set -l curr_pos (echo (dirh | grep -v --line-number [0-9]\) )[1] | string split ":")[1]
    #set -l dirh_list (echo -n -s (dirh | string split ')')\n | strip_ansi_color | grep -v [0-9] | string trim)
    #set -l dirh_list (echo -n -s (dirh | string split ')')\n | strip_ansi_color | grep -v [0-9] | string trim)[1..-2]
    #echo $dirh_list
    #set -l dir_indexes (seq 1 (test $curr_pos -gt 1; and math $curr_pos -1; or echo $curr_pos)) (test $curr_pos -ne (count $dirh_list); and seq (math $curr_pos +1) (count $dirh_list))
    #echo $dir_indexes

    #set dirh_list[$curr_pos] "."
    #for i in (seq 1 (count $dirh_list))
    #for i in $dir_indexes
    #echo at index $i
    #echo $dirh_list[$i]
    #test (string split "" $dirh_list[$i])[1] = "/"
    #or set dirh_list[$i] /$dirh_list[$i]
    #set dirh_list[$i] (eval echo (colorpwd $dirh_list[$i] no text))
    #set dirh_list[$i] (eval echo (cd $dirh_list[$i]; and colorpwd; and prevd))
    #echo $dirh_list[$i]
    #end
    for dir in $dirprev
        eval echo (colorpwd $dir no text)
    end
    echo "."
    for dir in $dirnext
        eval echo (colorpwd $dir no text)
    end
    #echo -n -s $dirh_list\n
end
