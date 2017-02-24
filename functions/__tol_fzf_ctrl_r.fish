function __tol_fzf_ctrl_r
type -q fzf
or return 1
set colorcmd "fish_indent --ansi --no-indent"

set -l linenr (commandline --line)
set -l cmdline (commandline | string split "\n")
set cmdline (string trim -- "$cmdline[$linenr]")
set -l cmdquery ""
not test -z "$cmdline" #just quote and these wont need redir to avoid spewing, dummy
and set cmdquery "-q '$cmdline'\ " #prepopulate search. wasnt working before with multiple words bc hadnt quoted

set -l preview 'history search --show-time --exact {} | fish_indent --ansi'
set -l fzfopts "--no-sort +m --toggle-sort=ctrl-r --preview='$preview' --preview-window=down:3:wrap \
--bind 'alt-enter:execute:/usr/local/bin/fish -c {}' $cmdquery"


debug -- "normal fzf window %s %s %s" $colorcmd $cmdline $fzfopts
if test -z "$cmdline"
set -l fish_term24bit 0 #cant use truecolor in fullscreen
set histsize (count $history)
set incr 10000
tput cud1
spin "sleep 5 &"
if test $histsize -gt $incr
set from 1
set to $incr
while test $to -ne $histsize #debug "from %s, to %s, incr %s" $from $to $incr
set lines $lines (echo -ns $history[$from..$to]\n | fish_indent --ansi --no-indent)

set from (math "$to+1")
set to (math "$to+$incr")
test $to -gt $histsize
and set to $histsize
end
echo -ns $lines\n | eval (__fzfcmd) "$fzfopts" | read --array fzf_last_select
#tput cuu1
end
else
get_line | read -l promptpos
set height (math "$LINES - $promptpos")
test $height -le 25
and set height '40%'
history search --contains "$cmdline" | eval $colorcmd | eval (__fzfcmd) "$fzfopts --height=$height --reverse --preview-window=up:3:wrap" | read --array fzf_last_select
end

debug "fzf selection: %s" $fzf_last_select
test $fzf_last_select[1]
and commandline -- "$fzf_last_select" #and if test (count (commandline -o)) -gt 2; commandline -rb -- (string join -- " " (commandline -o)[3..-1]); end #>2 tok use 3..last if inline timestamps
commandline -f repaint
end
