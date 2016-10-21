function lsc
	#	command ls -G $argv
    set output (command ls -G $argv)
    test -z $argv[1]
    #or set argv (echo -s -n "$argv[1]"/)
    #count $output
    test (count $output) -gt 0
    and for i in (seq 1 (count $output))
        #echo $output[$i]
        #echo -s $argv $output[$i]
        set label (get_label $output[$i])
        #(string join $argv[1] $output[$i])) #{$argv}{$output[$i]}) #(pwd)/$output[$i])
        #echo -n $label
        string match -q $label None
        or set output[$i] (string replace $output[$i] (set_color $label)$output[$i](set_color normal) $output[$i])
        #,
    end
    #string replace "" "" $output

    test -z (echo $output)
    or echo -n $output\t
    #or for line in $output
    #echo $line
    #end
end
