function __tol_insert_paran -a location
not test -z "$location"
and switch "$location"
case 'left'
set -l pos (commandline --cursor)
commandline --replace --current-token -- '('(commandline --current-token)
commandline --cursor (math "$pos + 1")
case 'right'
commandline --append --current-token ')'
end
end
