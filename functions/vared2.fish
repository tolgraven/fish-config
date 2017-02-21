function vared2 --description 'interactively edit entire array (only splits on lines), or by key' --argument array key
if test (count $argv) = 1
switch $argv

case '-h' '--h' '--he' '--hel' '--help'
__fish_print_help vared
return 0

case '-*'
printf (_ "%s: Unknown option %s\n") vared $argv
return 1

case '*'
if test (count $$argv ) -lt 2
set -l init ''
if test $$argv
set init $$argv
end
set -l prompt 'set_color green; echo '$argv'; set_color normal; echo "> "'
if read -p $prompt -c $init tmp

# If variable already exists, do not add any
# switches, so we don't change export rules. But
# if it does not exist, we make the variable
# global, so that it will not die when this
# function dies

if test $$argv
set $argv $tmp
else
set -g $argv $tmp
end
end
else
#printf (_ '%s: %s is an array variable. Use %svared%s %s[n]%s to edit the n:th element of %s\n') vared $argv (set_color $fish_color_command; echo) (set_color $fish_color_normal; echo) $argv (set_color normal; echo) $argv
end
end
else
#printf (_ '%s: Expected exactly one argument, got %s.\n\nSynopsis:\n\t%svared%s VARIABLE\n') vared (count $argv) (set_color $fish_color_command; echo) (set_color $fish_color_normal; echo)
end

if test -z "$key"

set -l IFS #shadow before setting init so get sep lines in read later
set init (echo -n $$array\n | fish_indent)

set -l prompt "printf '> '"
set -l right_prompt (__tol_make_ed_right_prompt "arred" brred $array brgreen (arrow)$scope)

set -l IFS \n #split array by newlines
read --prompt "$prompt" --right-prompt "$right_prompt" --shell --command "$init" --array newarray
and set $array $newarray
else
set -l index (contains -i $key $$array)
and vared "$array"[$index]
end
end
