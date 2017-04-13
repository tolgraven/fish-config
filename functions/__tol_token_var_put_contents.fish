function __tol_token_var_put_contents
set -l token (commandline --current-token)
if set -q $token #var, no dollar
set contents $$token
else if set -q (string sub --start 2 -- $token) #var, with dollar
set contents (eval echo $token)
end
debug "token: $token, contents: $contents"
test -z "$contents"
and return

commandline_save token_var_put_contents

set -l pos (commandline --cursor)
commandline --current-token "$contents" #$$contents
commandline --cursor $pos
commandline -f repaint
end
