function __tol_clipboard_paste
#set -l lines (pbpaste)
pbpaste | while read -l line
set lines $lines "$line"
end
for line in $lines
set new "$new" "$line" #easiest way to not get any extra linebreaks
end
commandline -i $new
end
