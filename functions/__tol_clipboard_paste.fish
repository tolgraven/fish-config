function __tol_clipboard_paste
set -l lines (pbpaste)
for i in (seq (count $lines))
test $i -eq (count $lines)
and commandline -i $lines[$i]
or commandline -i $lines[$i]\n
end
end
