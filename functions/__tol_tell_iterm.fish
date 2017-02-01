function __tol_tell_iterm
set -l prompt "printf 'iterm> '"
set -l rightprompt (__tol_make_ed_right_prompt "tell" brpurple "session" brred "iterm")
read --prompt "$prompt" --right-prompt "$rightprompt" --command "$argv" --shell to_iterm
if test -z "$to_iterm"
tput cuu1
tput dl1
tput cuu1
else
iterm_tell_session $to_iterm
end

commandline -f repaint
end
