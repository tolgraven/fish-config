function tol_up-or-search --description 'up-or-search with auto completion popup' --argument preview_count
if commandline --search-mode # If we are already in search mode, continue
commandline -f history-search-backward #test move up
clear_below_cursor
set his $__tol_up_or_search_hist
set from (contains -i -- (commandline --current-buffer) $his[1..100])
test -z "$from"
and return

set from (math "$from + 2") #1 instead of 2 bc -f moved up   #2") #dunno why this offset
set to (math "$from + $preview_count - 1")
#tput civis
tput cud1

set output $__tol_up_or_search_ansi[$from..$to]
for i in (seq 1 $preview_count)
set hist_i (math $i + $from - 1)
set col (math $last_prompt_length - 2 - (string length "$hist_i"))
set outlines[$i] (printf "%*s" $col (echo -s (set_color red) $hist_i (set_color normal) '. ' $output[$i]) )
#(echo -s (tput hpa $col) (set_color red) $hist_i (set_color normal) ". " $output[$i])
end
echo -ns $outlines\n
tput cuu (math "$preview_count + 1")
#tput cnorm

return
end

if commandline --paging-mode # If we are navigating the pager, then up always navigates
commandline -f up-line
return
end

set lineno (commandline -L) # We are not already in search mode. If we are on the top line, start search mode, otherwise move up
switch $lineno
case 1
set -g __tol_up_or_search_hist (history) #cache it for if paging continues and get around fish bug, cant access command substitution ranges using vars...
set his $__tol_up_or_search_hist
set from 2
set to (math 1 + $preview_count)
tput civis
clear_below_cursor
tput cud1
set col (math "$last_prompt_length - 2 - 1") #-3 bc .+space+digit = 3 chars behind.
set -g __tol_up_or_search_ansi (echo $his[1..100]\n | fish_indent --no-indent --ansi)
set output $__tol_up_or_search_ansi[$from..$to]
for i in (seq 1 $preview_count) #(seq $from $to)
set hist_i (math $i + $from - 1)
echo -s (tput hpa $col) (set_color red) $hist_i (set_color normal) ". " $output[$i]
end
tput cuu (math "$preview_count + 1") #correct
tput cnorm
commandline -f history-search-backward
case '*'
commandline -f up-line
end
end
