function funcat --description 'cat a function, with fun colors'
if isatty stdout
and status is-interactive
set color "--ansi"
else
set hide
end

set output (functions $argv | fish_indent $color | string replace --all '    ' '  ' ) #| read output
if set -q hide
debug "filter out first junk line from $argv"
string match --all -v -r '# Defined in /' $output
else
echo -ns $output\n
end
end
