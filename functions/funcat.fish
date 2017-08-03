function funcat --description 'cat a function, with fun colors'
if isatty stdout
and status is-interactive
set color "--ansi"
else
set hide
end

set output (functions $argv | fish_indent $color | string replace --all '  ' '  ' )
if set -q hide
debug "filter out first junk line from $argv"
else
echo -ns $output\n
end
end
