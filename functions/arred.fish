function arred --description 'interactively edit entire array (only splits on lines), or by key' --argument array key
    if test -z "$key"
        contains $array (set -Un)
        and set scope (set_color -o brblue)' U'(set_color normal) # ' U '
        contains $array (set -gn)
        and set scope (set_color -o yellow)' G'(set_color normal) # ' G '
        contains $array (set -ln)
        and set scope (set_color -o normal)' L'(set_color normal) #' L '

        set -l IFS #shadow before setting init so get sep lines in read later? still not grasping heh
        set init (echo -n $$array\n | fish_indent)

        set -l right_prompt (__tol_make_ed_right_prompt "arred" brred $array brgreen (arrow)$scope)

        set -l IFS \n #set -e IFS #unshadow _before_ do read or splits every char
        read --prompt "" --right-prompt "$right_prompt" --array --mode-name "arred" --shell --command "$init" newarray
        and set $array $newarray
    else
        set -l index (contains -i $key $$array)
        and vared "$array"[$index]
    end
end
