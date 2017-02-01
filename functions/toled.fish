function toled --description 'Inline text editor built on fish read' --argument file option
#set -l filename
#set -l opt
while set -q file
switch $file
case '-n' '--no-cat' '-B' '--no-backup' '--no-indent' '-*indent*' #don't cat orig state to cmdline before opening editor
set opt $file
set file $option
case '-*'
return 1
case '*' '.*'
if test -e $file
test -w $file
and set filename $file
or tint: red "File not writable"
else
touch $file
and set filename $file
and set new
or tint: red "Can't create file"
set opt "--no-cat" "--no-backup" $opt
end
set -e file
end
end
test (count $filename) -ne 1 #fallback test
and return 1

set -l IFS
string match -q -- "indent" $opt
and set init (cat $filename | fish_indent)
or set init (cat $filename) #if not contains -- $opt "-n" "--no-cat"; and not test -z $init; echo "Original file, for comparison while editing: "; end
set -l printname (/usr/local/bin/realpath --relative-base ~ $filename; or echo $filename) #where did the realpath wrapper func shipped with fish go?
set -l prompt 'printf "<%s> \t\t %s\n " (set_color brgreen)"$printname"(set_color normal) (tput smso)"c-q exit, c-s save, no c-c."(tput rmso)'
set -l right_prompt (__tol_make_ed_right_prompt "toled" cyan "$filename" brred)
toled_bind_mode
while not set -q toled_exit
read --prompt "$prompt" --right-prompt "$right_prompt" --command "$init" --mode-name "toled" --shell text
set init (echo $text)
end
tol_reload_key_bindings

if not test "$toled_exit" = "save"
echo "Editing aborted."
set -q new
and rm $filename
set -e toled_exit
return
end

tint: blue "INNA TMPFILE," (tint: green "backing up and replacing") (tint: brred (bold: $filename))
set -l backup_folder (dirname ~/.cache/toled/backups(realpath $filename))
mkdir -p $backup_folder
and cp $filename $backup_folder/$filename
or cp $filename {$filename}_BAK

set -l output (echo -s -n $init\n | perl -pe 's/\e\[?.*?[\@-~]//g') # strip ansi color codes
set -l prefix (string sub -l 6 -- $output[1])
test "$prefix" = "echo '" #; or debug "broken, prefix: " $prefix
if test (count $output) -gt 2 #BELOW REMOVES THE WRAPPER ADDED BY C-s binding in toled_bind_mode
echo -n -s (string sub -s 7 $output[1])\n $output[2..-2]\n (string trim -r -c \' $output[-1]) >"$filename"
else if test (count $output) -gt 1
echo -n -s (string sub -s 7 $output[1])\n (string trim -r -c \' $output[-1]) >"$filename"
else
echo -n -s (string sub -s 7 $output[1] | string trim -r -c \' ) >"$filename"
end
set -e toled_exit
end
