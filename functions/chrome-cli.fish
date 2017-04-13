function chrome-cli --argument action
if not isatty 1
command chrome-cli $argv
return $status
end
switch "$action"
case '-h' '--help' 'help'
chrome-cli -h | string replace '(' '    # ' | string replace ')' '' | fish_indent --no-indent --ansi | string replace '#' (tput hpa 45)'#' | string replace '>' (tput cub1)'>' | string replace '>-' '>'(set_color normal)' -' | string replace -- ' -' (set_color yellow)' -' | string trim #nicer presentation eh
return
case 'open'
string match -q -- 'http*' $argv[2]
or set argv[2] "http://$argv[2]"
end

set -l output (command chrome-cli $argv)
string match -q 'No matching handler found' $output
and return 1
or echo -ns $output\n
end
