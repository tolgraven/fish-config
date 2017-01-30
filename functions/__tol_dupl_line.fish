function __tol_dupl_line
#kill, paste back, go to start, go up, paste again. prob gaining line from the kill somehow? insert just wrecks it
set -l cmdline (commandline)
test -z "$cmdline"
and return

set -l pos (commandline --cursor)
set -l line (commandline --line)
set -l line_count (count $cmdline\n)
set -l after_part (set from (math "$line + 1"); test $from -gt $line_count; and set from $line_count; echo -ns $cmdline[$from..$line_count]\n)
set -l cmdline_new $cmdline[1..$line] $cmdline[$line] $after_part


commandline $cmdline_new
commandline --cursor $pos
#for i in (seq 1 $line)
#end
#commandline -f kill-whole-line
#commandline -f yank
#commandline -f beginning-of-line #commandline -f repaint #noneed
#if test (commandline --line) -gt 1
#commandline -f up-line
#else
#commandline -i \n
#end
#commandline -f yank
#commandline -C $pos

#set -l lineindex (commandline -L); set -l contents (commandline)[$lineindex]
#commandline (string replace $contents $contents\n$contents (commandline))
end
