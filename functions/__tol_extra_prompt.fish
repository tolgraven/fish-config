function __tol_extra_prompt --description 'floating extra prompt anywhere'
set -l prompt "printf '    %s:%s' (set_color red) (set_color normal)" #something like this?
#set -l rightprompt (__tol_make_ed_right_prompt "extra prompt" brpurple " " brred " ") #cant just send empty str bc default check ugh
set -l rightprompt "printf '%sextra prompt%s' (set_color -b brpurple) (set_color normal)"
read --prompt "$prompt" --right-prompt "$rightprompt" --command "$argv" --shell to_eval
if test -z "$to_eval"
tput cuu1
tput dl1
tput cuu1
else
eval $to_eval
end
commandline -f repaint
end
