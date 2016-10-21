
set -g __complete_spotify (echo -n \
"play/pause         - Toggle playback
  next               - Next track
  prev               - Previous track
  info               - Print track info
  jump              - Jump to N seconds in the song
  forward           - Jump N seconds forwards
  rewind            - Jump N seconds backwards
  shuffle            - Toggle shuffle
  repeat             - Toggle repeat
  volume            - Set Volume to N 0...100
  increasevolume    - Increment Volume by N 0...100
  decreasevolume    - Decrement Volume by N 0...100")


function __complete_spotify
    for comp in $__complete_spotify  #(math (count $__complete_spotify) / 2))
set comp (string split -- "-" $comp | string trim)
echo -s $comp[1] \t $comp[2]        
#echo -s -n $__complete_spotify[$i] \t
        #set j (math $i + 1)
        #echo -s -n $__complete_spotify[$j] \n
    end
end

complete -xc spotify -n "__fish_is_token_n 2" -a "(__complete_spotify)"
