function arred --description 'interactively edit entire array (only splits on lines), or by key' --argument array key
if test (count $$array) -eq 1 #regular var 
vared $array
return $status
end
if test -z "$key"
if contains $array (set -Un)
set scope (set_color -o brblue)' U'(set_color normal) # ' U '
else if contains $array (set -gn)
set scope (set_color -o yellow)' G'(set_color normal) # ' G '
else if contains $array (set -ln)
set scope (set_color -o normal)' L'(set_color normal) #' L '
end

set -l IFS #shadow before setting init so get sep lines in read later
set init (echo -n $$array\n | fish_indent)

set -l prompt "printf '> '"
set -l right_prompt (__tol_make_ed_right_prompt "arred" brred $array brgreen (arrow)$scope)

set -l IFS \n #split array by newlines
read --prompt "$prompt" --right-prompt "$right_prompt" --array --mode-name "arred" --shell --command "$init" newarray
and set $array $newarray
else
set -l index (contains -i $key $$array)
and vared "$array"[$index]
end
end
