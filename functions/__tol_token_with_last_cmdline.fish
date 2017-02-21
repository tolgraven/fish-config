function __tol_token_with_last_cmdline --description 'add !! and execute'
set -l cmdline (commandline)
set -l last_char (string split -- '' $cmdline)[-1]
string match -q -- $last_char ' '
or commandline --insert ' '

#commandline -f history-search-backward
commandline --insert $history[1]
#commandline $cmdline(commandline) #put it all together
commandline -f execute
end
