function tol_token-search-backward
#set -l token (commandline --current-token)
set -l token (commandline --tokenize)[-1]
set -l candidates (history search --max 20 --prefix "$token" )
commandline -f history-token-search-backward

set -l output (echo -ns $candidates[1..5]\n | fish_indent --ansi)
get_col | read -l col
tput hpa $col
echo -ns $output\n
end
