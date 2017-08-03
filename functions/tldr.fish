function tldr --description 'fishier tldr output yeh' --argument command
    type -q tldr
    or return 1
    test (count $argv) -gt 1
    and if string match -q -- '-*' $argv[2]
        command tldr
        return
    end
    set output (command tldr $argv | strip_ansi_color | strip_empty_lines)
    or return $status
    echo $output | grep -q -v "This page"
    or return

    set -l command $output[1]
    set -l desc $output[2]
    set -l firstdash (echo -n $output\n | grep --line-number -- '- ' | string split -- ":")[1] #desc can be multiline so look
    debug "index of first dashed line:   %s" $firstdash
    set -l strings $output[$firstdash..-1]

    set -l copy $strings
    set -l i 1
    while set -q copy[2]
        set cmds $cmds (echo -n $copy[2] | fish_indent)
        set cmd_len[$i] (string length -- $cmds[$i])
        set rough_offset[$i] (test $cmd_len[$i] -ge 10; and string sub -s 1 -l 1 -- $cmd_len[$i]; or echo 0)
        set offset[$i] (math (math $rough_offset[$i] + 1) "* 10")
        set diff[$i] (math "$offset[$i] - $cmd_len[$i]")
        debug "cmd_len %s   rough_offset %s   offset %s   diff %s   i %s" $cmd_len[$i] $rough_offset[$i] $offset[$i] $diff[$i] $i
        test $offset[$i] -lt 30
        and set offset[$i] 30
        set i (math $i + 1)
        set descs $descs (substr $copy[1] 2 0)
        set -e copy[1..2]
    end
    set -l longestlength (strlen_longest $cmds) #$strings)
    debug "longest command is %s" $longestlength
    set -l paths_n_shit "path" "file" "url" "remote" "http" "://" "drive" "volume" "disk" "user"
    echo -s (set_color --bold blue)(tput smso)" $command "(set_color normal) " $desc" #HEADER

    for i in (seq 1 (count $cmds))
        set -l indented (echo -n $cmds[$i] | fish_indent --ansi) #command
        for thing in $paths_n_shit
            set indented (string replace "$thing" (set_color $fish_color_valid_path)"$thing" $indented)
        end
        set indented (string replace '@' (tput smso)@  $indented)
        echo -n $indented
        test $diff[$i] -ge 9
        and set offset[$i] (math "$offset[$i] - 10")
        tput hpa $offset[$i] #$longestlength + 3)
        echo -s (set_color $fish_color_comment) '# ' (string sub -l (math (tput cols) "- $offset[$i] - 4") -- $descs[$i]) #(substr $descs[$i] 2 0) #$strings[1] 2 0) #description  #printf '%*s %s %s%s \n' $longestlength (set_color $fish_color_comment) '#' (string sub --start 2 --length (math (string length -- $strings[1]) - 2) -- $strings[1]); set -e strings[1..2]
    end
end
