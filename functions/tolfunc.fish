function tolfunc --description 'Edit function definition' --argument function
test -z "$function"
and return 1

set -l IFS #to preserve linebreaks
if functions -q -- $function
#set init (functions -- $function | fish_indent --no-indent) #must run indent or breaks when around top of file.weird
set init (funcat $function) #must run indent or breaks when around top of file.weird
else
set init function $function\n\nend
end
set -e IFS

set -l prompt ''
# set -l right_prompt 'printf "%stolfunc%s editing %s%s%s " \
# (tput smso)(set_color brblue) (set_color normal)   (set_color green)(tput smso) "$function" (set_color normal)'
set -l right_prompt (__tol_make_ed_right_prompt "tolfunc" brblue $function green)

if read --prompt $prompt --right-prompt "$right_prompt" --command "$init" --mode-name inlined --shell cmd #HERE SHOULD HAVE SOMETHING TO INDICATE IF THESE HAS BEEN ANY CHANGE WHILE EDITING. put in right_prompt somehow hmm?
set -l IFS #no need since just passing it on to func using echo #massively incorrect assumption
echo -ns $cmd\n | fish_indent --no-indent
end
end
