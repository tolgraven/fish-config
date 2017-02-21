function tol_up-or-search --description 'up-or-search with auto completion popup' --argument preview_count
set lineno (commandline -L)
if commandline --search-mode # If we are already in search mode, continue
commandline -f history-search-backward

set preview_count (math "$LINES - $__search_line_nr - 2") #dynamic count, size - pos - padding
or set preview_count 7
test $preview_count -lt 7
and set preview_count 7
test $preview_count -gt 15
and set preview_count 15

set from (contains -i -- (commandline --current-buffer) $__tol_up_or_search_hist)
or return
set from (math "$from + 2") #1 instead of 2 bc -f moved up   #2) #dunno why this offset
set to (math "$from + $preview_count - 1")

set output $__tol_up_or_search_ansi[$from..$to]
tput cud1
clear_below_cursor
for i in (seq 1 $preview_count)
set hist_i (math "$i + $from - 1")
set hist_i_len (string length -- "$hist_i")
set col (math "$last_prompt_length - 2 - $hist_i_len") ^&- #debug "col %s" $col
test -z "$col"
and set col 2
#set outlines[$i] (tput hpa $col)(set_color red)$hist_i(set_color normal).\ $output[$i]
set outlines[$i] (set_color red)$hist_i(set_color normal).\ $output[$i]
end
#echo -n (tput hpa $col) $outlines\n
printf "%s%s" (tput hpa $col)$outlines\n
tput cuu (math "$preview_count + 1")

else if commandline --paging-mode # If we are navigating the pager, then up always navigates
commandline -f up-line
else if test $lineno -eq 1 # Not already in search mode. Start search mode or move up
get_line | read -g __search_line_nr #only need to grab line nr once. or not?
commandline -f history-search-backward
set -g __tol_up_or_search_hist $history[1..100] #cache it for if paging continues
set -g __tol_up_or_search_ansi (echo $__tol_up_or_search_hist\n | fish_indent --ansi)
set from 2 #beginning index
set to (math "1 + $preview_count") #last index
set col (math "$last_prompt_length - 2 - 1") #-3 bc .+space+digit = 3 chars behind.
#debug "count post-fish_indent %s" (count $__tol_up_or_search_ansi)
set output $__tol_up_or_search_ansi[$from..$to]
tput cud1
clear_below_cursor
for i in (seq 1 $preview_count)
set hist_i (math "$i + $from - 1")
echo -s (tput hpa $col) (set_color red) $hist_i (set_color normal) ". " "$output[$i]"
end
tput cuu (math "$preview_count + 1") #correct
else
commandline -f up-line
end
end
