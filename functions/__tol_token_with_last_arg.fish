function __tol_token_with_last_arg --description '!$ and execute'
set -l cmdline (commandline)
set -l last_char (string split -- '' $cmdline)[-1]
string match -q -- $last_char ' '
or commandline --insert ' '

commandline -f history-token-search-backward
and commandline -f execute
end
