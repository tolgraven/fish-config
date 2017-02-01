function tol_down-or-search --description 'up-or-search with auto completion popup' --argument preview_count
if commandline --search-mode # If we are already in search mode, continue
debug "history search forward"
clear_below_cursor
commandline -f history-search-forward

set his $__tol_up_or_search_hist
set from (contains -i -- (commandline --current-buffer) $his[1..100])
switch "$from"
case 0 1 ''
return
end
#test -z "$from"
#and return

set from (math "$from + 0") #dunno why this offset
set to (math "$from + $preview_count - 1")
tput civis
clear_below_cursor
tput cud1

set output $__tol_up_or_search_ansi[$from..$to]
set -l skipped 0
for i in (seq 1 $preview_count) #i counts preview lines
if not set -q output[$i]
set skipped (math $skipped + 1)
continue
end
set hist_i (math $i + $from - 1) #the actual index
set col (math $last_prompt_length - 2 - (string length "$hist_i"))
echo -s (tput hpa $col) (set_color red) $hist_i (set_color normal) ". " $output[$i]
end
tput cuu (math (math $preview_count - $skipped) + 1)
tput cnorm

return
end

if commandline --paging-mode # If we are navigating the pager, then up always navigates
debug "paging mode"
commandline -f down-line
return
end

set lineno (commandline -L) # We are not already in search mode.
set line_count (count (commandline))
switch $lineno
case $line_count
#debug "history search forward - lineno = line_count = %s" $lineno
#commandline -f history-search-forward
#return
case '*'
debug "down-line"
commandline -f down-line
end
end
