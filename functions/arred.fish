function arred --description 'interactively edit entire array (only splits on lines), or by key' --argument array key
	if test -z $key #set $array $$array ""; set index (count $$array)
        set -l IFS #shadow before setting init so get sep lines in read later? still not grasping heh
        set init (echo -n $$array\n | fish_indent)
        set -l prompt "" #"printf '%s %s%s%s>\n ' 'Editing array' (set_color green) $token (set_color normal)"
        #set -l clocky (fish_right_prompt)
        set -l right_prompt "printf '%sarred%s editing %s%s%s'   (tput smso)(set_color brred)  (set_color normal)  \
(set_color brgreen)(tput smso) $array (set_color normal)" #(tput smso)(string sub --start=-6 $clocky)(set_color normal)"

        set -l IFS \n #set -e IFS #unshadow _before_ do read or splits every char
        read --prompt "$prompt" --right-prompt "$right_prompt" --array --mode-name "arred" --shell --command "$init" newarray
        and set $array $newarray
    else
        set -l index (contains -i $key $$array)
        and vared "$array"[$index]
    end
end
