function __tol_insert_left_paran
set -l pos (commandline --cursor)
commandline --replace --current-token -- '('(commandline --current-token)
commandline --cursor (math "$pos + 1")
end
