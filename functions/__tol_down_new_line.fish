function __tol_down_new_line
set -l cmdline (commandline)
test -z "$cmdline"
and return

set -l pos (commandline --cursor)
set -l line (commandline --line)
set -l line_count (count $cmdline\n)
test $line_count -gt $line
and set -l after_part (set from (math "$line + 1"); test $from -gt $line_count; and set from $line_count; echo -ns $cmdline[$from..$line_count]\n)
set -l cmdline_new $cmdline[1..$line] "" $after_part

commandline $cmdline_new
commandline --cursor $pos
commandline -f down-line
end
