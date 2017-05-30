function fish_colors --description 'show or export fish colors' --argument file
if not test -z "$file"
set -l output (fish_colors | strip_ansi_color)
for line in $output
echo "set -U" $line >>$file
end
return
end
set output (set --names | string match "*fish*color*")

set longestvar_len (strlen_longest $output\n)
set longestparam_len (strlen_longest $$output\n) #$parambuf) #borken, splits

for color_var in $output
tput hpa 0
set params_joined (for param in $$color_var; set_color (string trim -- $param); echo -n $param; tput cuf 1; end)
set params_joined_list $params_joined_list "$params_joined"
set params_joined_nocolor (for param in $$color_var; echo -n $param; end)
set params_joined_nocolor_list $params_joined_nocolor_list "$params_joined_nocolor"

set color_vars_list $color_vars_list (echo -s (for param in $$color_var; set_color (string trim -- $param); end) $color_var (set_color normal) )
echo -n $color_vars_list[-1]

tput hpa (math "$longestvar_len + 2")
set -l switches (echo -n $params_joined | strip_ansi_color | string sub -l 2)
and switch $switches
case '--'
tput cub 2 #back up to align
case '-*'
tput cub 1
end
#set full $full (printf "%s \n " $params_joined(set_color normal)) #whoops obvs doesn't work with this setup...
printf "%s \n " $params_joined(set_color normal)
end

debug -- "color var array %s  count %s   params array %s   count %s" $color_vars_list\n (count $color_vars_list) $params_joined_nocolor_list\n (count $params_joined_nocolor_list)
set -l IFS \n

set -l init_params (echo $params_joined_nocolor_list\n | fish_indent)
set color_vars_nocolor_list (echo -n $color_vars_list\n | strip_ansi_color | fish_indent)
set color_vars_nocolor_list ""
end
