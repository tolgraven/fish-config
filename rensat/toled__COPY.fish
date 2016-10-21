function toled --description 'Inline text editor built on fish funced' --argument file option
	set -l filename
set -l opt
set -l new false
while set -q file
switch $file
case -n --no-cat
set opt $file
set file $option #don't cat orig state to cmdline before opening editor
case '-*'
return 1
case '*' '.*'
if test -e $file
test -w $file
and set filename $file
or tint: red "File not writable"
else
touch $file
and begin
set filename $file
set new true
end
or tint: red "Can't create file"
set opt "--no-cat" $opt
end
set -e file
end
end
if test (count $filename) -ne 1 #fallback test
tint: red "Someone fucked up"
return 1
end
set -l IFS
set -l init

string match -q $option "indent"
and set init (cat $filename | fish_indent)
or set init (cat $filename)

if not contains -- $opt "-n" "--no-cat"
and not test -z $init
echo "Original file, for comparison while editing: "
cat $filename #| fish_indent --ansi
end
toled_bind_mode #keybindings yea

set -l prompt 'printf "%s%s%s>\n " (set_color green) '(realpath -z --relative-base ~ $filename; or echo $filename)' (set_color normal)'
set -l right_prompt 'printf "%s" "ctrl-q exit, ctrl-s save, dont you dare ctrl-c"'
#set -l prompt (echo -n -s (set_color green) (realpath -z --relative-base ~ "$filename"; or echo "$filename") (set_color normal)"...") #set -e IFS          # Unshadow IFS since the fish_title breaks otherwise
while not set -q toled_exit
read --prompt "$prompt" --right-prompt "$right_prompt" -c "$init" -s text
set -l IFS # Shadow IFS _again_ to avoid array splitting
set init (echo $text)
end

tol_reload_key_bindings
set -e IFS # joen test unshadow ifs bc want sep lines!

if test $toled_exit != "graceful"
tint: blue "INNA TMPFILE," (tint: green "backing up and replacing") (tint: orange (bold: $filename))
cp $filename {$filename}_BAK #(dirname $filename)/.(basename $filename)_BAK
set -l output (echo -s -n $init\n | perl -pe 's/\e\[?.*?[\@-~]//g') # strip ansi color codes
echo -n -s (string sub -s 7 $output[1])\n $output[2..-2]\n (string trim -r -c \' $output[-1]) >"$filename"
#echo -s $output[1] | string sub -s 7 >$filename # trim leading echo and quote part
#echo -n -s $output[2..-2]\n >>$filename
#echo -s $output[-1] | string trim -r -c \' >>$filename
set -l stat $status
set -e toled_exit
return $stat
else if test $toled_exit = "graceful"
echo "Editing aborted."
test $new = "true"
and type -q trash
and trash $filename
set -e toled_exit
end
end
