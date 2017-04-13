function +x -d "chmod +x token"
set -l token (commandline --current-token)
not test -e "$token"
and return 1

chmod +x $token ^&-
or sudo chmod +x $token
end
