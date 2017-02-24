function imgcat --description 'alias imgcat=~/.iterm2/imgcat' --argument file height
not test -z "$height"
and set height ";height=$height"
printf "\033]1337;File=inline=1;width=100%%$height;preserveAspectRatio=1"
printf ":"
base64 <"$file"
printf '\a\n'

#~/.iterm2/imgcat $argv
end
