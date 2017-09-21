function tol_execute --description 'do stuff, then execute'
set -l cmdline (commandline)
set -l linenum (commandline --line)
if not commandline --paging-mode
and not commandline --search-mode
clear_below_cursor
end

set -l highlighter 'highlight'
test "$linenum" -eq 1
#    and if string match -r -q -- ' --help| -h | --detailed-help| --version' $cmdline
#        commandline --append " | $highlighter"
#    end
commandline -f execute
end
