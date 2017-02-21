function clear_below_cursor
#dunno why this escape works and the tput version doesnt...
printf "\033[J"
#tput cuu1 #return to previous line
#echo -ns (printf "\033[J")
end
