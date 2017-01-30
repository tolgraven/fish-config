function funcrm --description 'remove saved function' --argument function
test -z "$function"
and return 1

set -l funcdir ~/.config/fish/functions
set -l funcfile "$funcdir"/$function.fish
if test -f "$funcfile"
type -q trash
and trash "$funcfile" ^&-
or mv $funcfile "$funcdir"/"$function".BAK_fish

functions -e $function #erase in shell

echo function (set_color brred)$function (set_color normal)"erased in-memory and from" (set_color brblue)$funcdir(set_color normal)
else
echoerr function (set_color brred)$function (set_color normal)"not in user function dir" (set_color brblue)$funcdir(set_color normal)", nothing done"
return 1
end
end
