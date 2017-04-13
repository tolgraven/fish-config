function __tol_la_text_replacements --description 'transform stuff for la'
set output $argv
test -z "$output"
and return 1

set output (string replace -- $HOME (set_color -o yellow)'~'(set_color normal) $output) #shorten symlinks
not string match -q -- '*root*' $output
and set output (string replace -- $USER (set_color brblue)(string sub -l 4 $USER)(set_color normal) $output)
or set output (string replace -- $USER (set_color brblue)$USER(set_color normal) $output)
set output (string replace -r -- "staff|admin|wheel|_unknown|501|502|503" "" $output) # groups, need better way
set output (string replace -- '@' (set_color black)'@'(set_color normal) $output) # xattr
set output (string replace -r -- '(20\d\d+)' (set_color black)'\$1'(set_color normal) $output) # years ie old get dimmed
set output (string replace --all -- '.' (set_color black)'.'(set_color brblue) $output) #fix per filetype, same scheme as labels... also should prob be done per line from left only changing the first-last part. +again pre-symlink
switch "$dirname"
case "*/Applications*"
set output (string replace -- "/usr/local/Caskroom" (set_color black)"Cask"(set_color normal) $output)
case "$HOME*"
set output (string replace -- "Google Drive/Mackup" (set_color red)'.ln'(set_color normal) $output)
end
set output (string replace -r -- '(\N\N\d+)(B+)\s*' '\$1'(set_color black)\ \ '\$2'(set_color normal) $output)
set output (string replace -r -- '(\N\N\d+)(K+)\s*' '\$1'(set_color bryellow)\ '\$2'B(set_color normal) $output)
set output (string replace -r -- '(\N\N\d+)(M+)\s*' '\$1'(set_color -o brred)\ '\$2'B(set_color normal) $output)
set output (string replace -r -- '(\N\N\d+)(G+)\s*' '\$1'(set_color red)\ '\$2'B(set_color normal) $output)
echo -ns $output\n
end
