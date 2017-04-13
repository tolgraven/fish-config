function __tol_token_check_help
set -l token (commandline --token)
not test -z "$token"
and set -l results (eval "$token --help" | strip_empty_lines)
test "$results"
and clear_below_cursor
and echo -ns \n $results\n | highlight
commandline -f repaint
end
