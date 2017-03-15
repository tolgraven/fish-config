function cliped
set -l right_prompt 'printf "editing %sclipboard%s"    (set_color brgreen)(tput smso)  (set_color normal)'

set -l IFS
read --prompt "$prompt" --right-prompt "$right_prompt" --command (pbpaste) --shell newclip
echo -n $newclip | pbcopy
commandline -f repaint
end
