function __tol_cat_token
set -l token (commandline --current-token)
not test -z "$token"
and cat $token
and commandline -f repaint
end
