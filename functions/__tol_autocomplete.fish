function __tol_autocomplete --description 'bind to - to auto call tab completion while typing'
commandline --insert -
set -l cmdline (commandline)
set -l token (commandline --current-token)
test "$cmdline" != "$token"
and switch $token
case '-' '-*'
if test (count (complete --do-complete="$cmdline")) -gt 1 #dont attempt to complete if just one alternative, since we might mean -- as in no-args
commandline -f complete
not commandline --paging-mode #if completion has just added an extra dash (bc no short opts available)
#and if test (count (complete --do-complete="$cmdline-")) -gt 1 #like before but with an extra dash
#debug "not paging yet"
#commandline -f complete 
#end #gets too messy. but lighter works, and concept worth exploring..
end
#case '---'
#commandline --current-token --
#commandline -f repaint
#commandline -f complete
end
end
