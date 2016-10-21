complete -xc tput -a '(__tput_complete)'
function __tput_complete
    set -l tput_comp_file ~/.config/fish/completions/.tput-comp
    set -q __tput_comps
    or set -g __tput_comps (command cat $tput_comp_file| strip_empty_lines | string trim)
    for i in (seq 1 (count $__tput_comps))
        set things (string split -- "-" $__tput_comps[$i] | string trim)
        echo -s $things[1] \t $things[2]
        #set descs[$i] (string split -- "-" $__tput_comps[$i])[2]
        #echo -s things[$i] \t $descs[$i]
    end
    echo -n $__tput_comps\n >$tput_comp_file

    #for i in (seq 1 (count $args))    
    #echo -s $args '\t' $descs
    #end
end
