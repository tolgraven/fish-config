function __tol_eval_line --description 'eval current line (not buffer) and show or yank result' --argument mode
set -l cmdline (commandline)
#and echo -n $cmdline\n
set -l line_num (commandline --line)
set -l line $cmdline[$line_num]
set -l output (eval $line ^&-)\n

set -l out_count (count $output)
switch "$mode"
case 'fzf'
test $out_count -gt 0
and set -l fzf_height (math "$out_count + 1")
and set -l fzfopts "--height $fzf_height --no-sort"
and echo $output | fzf | read --array output
#echo -ns $output
and commandline $output
case 'read' #buggy
set -l prompt "printf result"
set -l rightprompt (__tol_make_ed_right_prompt "eval" red $line_num yellow "line")
and read --prompt "$prompt" --right-prompt "$rightprompt" --command "$output" --array output
echo -ns $output
end

commandline -f repaint
end
