function tol_down-or-search --description 'up-or-search with auto completion popup' --argument preview_count
if commandline --search-mode # If we are already in search mode, continue
commandline -f history-search-forward

set from (contains -i -- (commandline --current-buffer) $__tol_up_or_search_hist[1..100])
switch "$from"
case 0 1 ''
clear_below_cursor
return
end
set to (math "$from + $preview_count - 1")
#tput civis
tput cud1
clear_below_cursor

set output $__tol_up_or_search_ansi[$from..$to]
set -l skipped 0
for i in (seq 1 $preview_count) #i counts preview lines
if not set -q output[$i]
set skipped (math $skipped + 1)
continue
end
set hist_i (math $i + $from - 1) #the actual index
set col (math $last_prompt_length - 2 - (string length "$hist_i"))
#echo -s (tput hpa $col) (set_color red) $hist_i (set_color normal) ". " $output[$i]
set outlines[$i] (echo -s (tput hpa $col) (set_color red) $hist_i (set_color normal) ". " $output[$i])
end
printf "%s%s" (tput hpa $col)$outlines\n
tput cuu (math (math $preview_count - $skipped) + 1)
#tput cnorm
else #if paging mode or nothing then always just down-line
commandline -f down-line
end
end
