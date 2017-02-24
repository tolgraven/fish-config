function clear_below_cursor
printf "\033[J" #dunno why this escape works and the tput version doesnt...

#this etc only works when called from a prompt?
#tput ed
end
