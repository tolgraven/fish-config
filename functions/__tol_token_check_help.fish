function __tol_token_check_help
set -l results (eval (commandline --token) --help)
test "$results"
and echo -ns $results\n | highlight
#commandline -f repaint
end
