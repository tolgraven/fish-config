function __tol_token_eval_replace
set -l token_output (eval (commandline --current-token))
test "$token_output"
and commandline_save eval #save in a common slot so all these can be reverted with one button
and commandline --current-token "$token_output"

commandline -f repaint
end
