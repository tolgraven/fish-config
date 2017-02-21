function __tol_put_contents --description 'replace var, etc, with its contents, in cmdline'
set -l token (commandline --current-token)
test -z "$token"
and return
test -z "$$token"
and return
commandline --current-token (echo $$token)
end
