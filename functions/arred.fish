function arred --description 'interactively edit entire array (only splits on lines), or by key' --argument array_pointer key
set -l count (count $$array_pointer)
switch "$count"
case 1 #regular var 
vared $array_pointer
return $status
case 0 #nothing
return 1
end
if test -z "$key"
if contains $array_pointer (set -Un)
set scope (set_color -o brblue)' U'(set_color normal) # ' U '
else if contains $array_pointer (set -gn)
set scope (set_color -o yellow)' G'(set_color normal) # ' G '
else if contains $array_pointer (set -ln)
set scope (set_color -o normal)' L'(set_color normal) #' L '
end

set -l IFS #shadow before setting init so get sep lines in read later
set init (echo -n $$array_pointer\n | fish_indent)

set -l prompt "printf '> '"
set -l right_prompt (__tol_make_ed_right_prompt "arred" brred $array_pointer brgreen (arrow)$scope)

set -l IFS \n #split array by newlines
read --prompt "$prompt" --right-prompt "$right_prompt" --array --mode-name "arred" --shell --command "$init" newarray
and set $array_pointer $newarray
else
set -l index (contains -i $key $$array_pointer)
and vared "$array_pointer"[$index]
end
end
