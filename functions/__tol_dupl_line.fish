function __tol_dupl_line
set -l cmdline (commandline)
test -z "$cmdline"
and return


set -l pos (commandline --cursor)
set -l line (commandline --line)
set -l line_count (count $cmdline\n)
set rest_from (math "$line + 1")
test $rest_from -le $line_count
#and set rest_from $line_count
#test $line_count -gt 1
and set -l after_part (echo -ns $cmdline[$rest_from..$line_count]\n)
#set -l after_part (set from (math "$line + 1"); test $from -gt $line_count; and set from $line_count; echo -ns $cmdline[$from..$line_count]\n)
set -l cmdline_new $cmdline[1..$line] $cmdline[$line] $after_part

commandline $cmdline_new
commandline --cursor $pos

switch "$argv"
case 'comment'
__tol_toggle_comment_commandline
commandline -f down-line
end
end
