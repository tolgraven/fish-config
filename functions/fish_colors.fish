function fish_colors
	set output (set --names | string match "*fish*color*")
    set longestvar_len (strlen_longest $output\n)
    set longestparam_len (strlen_longest $$output\n) #$parambuf) #borken, splits

    for color_var in $output
        tput hpa 0
        set params_joined (for param in $$color_var; set_color (string trim -- $param); echo -n $param; tput cuf 1; end)
        set params_joined_list $params_joined_list "$params_joined"
        set params_joined_nocolor (for param in $$color_var; echo -n $param; end)
        set params_joined_nocolor_list $params_joined_nocolor_list "$params_joined_nocolor"

        #set together_len (string length $params_joined); debug "full params len %s   with params %s" $together_len $params_joined
        #printf "%*s" (math $longestparam_len) $params_joined #"$$color_var"
        #tput hpa (math $longestparam_len + 10)
        set color_vars_list $color_vars_list (echo -s (for param in $$color_var; set_color (string trim -- $param); end) $color_var (set_color normal) )
        echo -n $color_vars_list[-1]

        tput hpa (math "$longestvar_len + 2")
        switch (echo -n $params_joined | strip_ansi_color | string sub -l 2)
            case '--'
                tput cub 2 #back up to align
            case '-*'
                tput cub 1
        end
        printf "%s \n " $params_joined(set_color normal)
        #printf "%*s%s\n " (math (tput cols) - 80) "$$color_var" (set_color normal)
        #echo -ns $color_var; tput hpa 30; printf "%*s%s\n" (math (tput cols) - 80) "$$color_var" (set_color normal)
    end
    #echo (count $color_vars_list) (count $params_joined_nocolor_list)
    debug -- "color var array %s  count %s   params array %s   count %s" $color_vars_list\n (count $color_vars_list) $params_joined_nocolor_list\n (count $params_joined_nocolor_list)
    set -l IFS \n #set -l params (echo -n $params_joined_formatted\n | strip_ansi_color)
    #set color_vars_list "printf '%s%s\n %s\n %s\n %s\n' (tput setaf 10) (echo hej) (echo "hoe") (echo "doe") (echo "fancy") "
    set -l init_params (echo $params_joined_nocolor_list\n | fish_indent) #set -l init (echo -n $$output\n | fish_indent)
    set color_vars_nocolor_list (echo -n $color_vars_list\n | strip_ansi_color | fish_indent)
    set color_vars_nocolor_list ""
    #debug "count "
    #read --prompt "" --right-prompt "$color_vars_nocolor_list" --command "$init_params" --array testarr #--shell #"$params_joined_nocolor_list" testarr
    #echo -n \n $testarr\n

    #echo -ns $params_joined_list\n \n
    #echo -ns $color_vars_list\n \n
end
