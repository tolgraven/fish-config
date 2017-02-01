function strip_duplicate_lines_file
for file in $argv
test -w $file
and set output (awk '!seen[$0]++' $file) #>$file #cant straight redirect for some reason
and echo -ns $output\n >$file
end
end
