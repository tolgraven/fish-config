function divider --description 'print terminal divider' --argument divider
set -l dir ~/.iterm2/divider
test -z "$divider"
and set divider $dir/blue-green.png
not test -f $divider
and set divider $dir/$divider.png

printf '\033]1337;File=inline=1;width=100%%;height=2;preserveAspectRatio=0'
printf ":"
base64 <"$divider"
printf '\a\n'
end
