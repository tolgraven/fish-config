function tol_execute --description 'clear lines below cursor, then execute'
#implement...
#set -l line (get_row)
#debug $line
#if not test $line = $LINES
#set lines 5
#set jump (math $line + $lines)
#debug $jump
#tput vpa $jump
#for i in (seq 1 $lines)
#tput dl1
#tput cuu1
#end
#end

clear_below_cursor
commandline -f execute
end
