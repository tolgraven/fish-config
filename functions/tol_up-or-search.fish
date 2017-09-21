function tol_up-or-search --description 'up-or-search with auto completion popup' --argument preview_count
if commandline --search-mode # If we are already in search mode, continue
commandline -f history-search-backward
test $TMUX
and clear_below_cursor
and return #temp fix for weirdness...
#set preview_count (math "$LINES - $__search_line_nr - 2") #dynamic count, size - pos - padding
set preview_count 5
test $preview_count -lt 5
and set preview_count 5
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
set max_length (math "$COLUMNS - $col")
#test $__tol_up_or_search_hist_lengths[$i] -gt $max_length
#test (echo $output[$i] | strip_ansi_color))
#and set output[$i] (string sub -l $max_length  | fish_indent --ansi) #trunc properly and re-color or escapes trick it.. 

set outlines[$i] (set_color red)$hist_i(set_color normal).\ (string sub -l (math "$COLUMNS - $col") "$output[$i]")
end #echo -n (tput hpa $col) $outlines\n
printf "%s%s" (tput hpa $col)$outlines\n
tput cuu (math "$preview_count + 1")

else if commandline --paging-mode
commandline -f up-line # If we are navigating the pager, then up always navigates
else if test (commandline -L) -eq 1 #$lineno -eq 1 # Not already in search mode. Start search mode or move up
#get_line | read -g __search_line_nr #only need to grab line nr once, first invocation. or not?
commandline -f history-search-backward
set -g __tol_up_or_search_hist $history[1..100] #cache it for if paging continues

set -g __tol_up_or_search_ansi (echo $__tol_up_or_search_hist\n | fish_indent --ansi)
set from 2 #beginning index
set to (math "1 + $preview_count") #last index
set col (math "$last_prompt_length - 2 - 1") #-3 bc .+space+digit = 3 chars behind.
set max_length (math "$COLUMNS - $col")
set output $__tol_up_or_search_ansi[$from..$to]
tput cud1
clear_below_cursor
debug "prompt col: %s, max length: %s" $col $max_length
for i in (seq 1 $preview_count)
set hist_i (math "$i + $from - 1") #FANCY IDEA: put timestamp when cmd was run prior to index, when prompt is long enough to allow it
echo -s (tput hpa $col) (set_color red) $hist_i (set_color normal) ". " (string sub -l $max_length "$output[$i]") #trunc if too long
debug "line length: %s" (string length $output[$i])
end
tput cuu (math "$preview_count + 1") #correct
else
commandline -f up-line
end
end
