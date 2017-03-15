function __tol_fzf_ctrl_r
type -q fzf
or return 1
set colorcmd "fish_indent --ansi --no-indent"
set -l linenr (commandline --line)
set -l cmdline (commandline | string split "\n")
set cmdline (string trim -- "$cmdline[$linenr]")
set -l cmdquery ""
not test -z "$cmdline" #just quote and these wont need redir to avoid spewing, dummy
and set cmdquery "-q '$cmdline'\ " #prefill search. wasnt working before with >1 word bc no quotes lol

set -l preview "--preview='history search --show-time --exact {} | fish_indent --ansi'"
set -l fzfopts "--no-sort +m --toggle-sort=ctrl-r $preview --bind 'alt-enter:execute:/usr/local/bin/fish -c {}' $cmdquery"

if test -z "$cmdline" #debug -- "normal fzf window %s %s %s" $colorcmd $cmdline $fzfopts
set -l fish_term24bit 0 #cant use truecolor in fullscreen
set fzfopts $fzfopts "--preview-window=down:3:wrap" #fullscreen, bottom preview window
set histsize (count $history)
set incr 10000
tput cud1
spin "sleep 5 &"
if test "$histsize" -gt "$incr" #do it in parts bc fish_indent crashes
set his $history #set his (history search --show-time)
set from 1
set to $incr
while test "$to" -ne "$histsize" #debug "from %s, to %s, incr %s" $from $to $incr
set lines $lines (echo -ns $his[$from..$to]\n | eval $colorcmd)
set from (math "$to+1")
set to (math "$to+$incr")
test "$to" -gt "$histsize"
and set to $histsize
end
else
set lines (echo -ns $history[$from..$to]\n | eval $colorcmd)
end
echo -ns $lines\n | eval (__fzfcmd) "$fzfopts" | read --array fzf_last_select #tput cuu1
return $stat
end
get_line | read -l promptpos
set height (math "$LINES - $promptpos")
test $height -le 25
and set height '40%'
set fzfopts $fzfopts "--height=$height --reverse --preview-window=up:3:wrap" #inline, below prompt
set timestamp_len 26 #chars #set his (history search --contains "$cmdline")
history search --show-time --contains "$cmdline" | while read line #debug $line
switch "$line"
case '# M|T|W|F|S' '# *'
set -q timestamp #arriving again at new timestamp = flush last assembled
and printf "%s %*s"\n "$hit_output" (math "$COLUMNS-$timestamp_len") (echo $timestamp | eval $colorcmd)
#and set -e timestamp #noneed since replacing it anyways no?
set timestamp $line
set new_hit
case '*'
set ansied (echo $line | eval $colorcmd)
test (count $ansied) -gt 2 #apparently spews an extra line so >2 == >1
#and debug "ansied %s lines, 1: %s, 2: %s" (count $ansied) $ansied[1] $ansied[2]
#and set ansied $ansied\; #reduce back anything fish_indent has seperated
and for ansi in $ansied
not test -z (echo $ansi | strip_ansi_color | strip_empty_lines)
and set outer $outer "$ansi; "
end
or set outer $ansied[1] #just grab the one good line
if set -q new_hit
set hit_output "$outer" #"$ansied" #grab ansi here so can keep own formatting etc
set -e new_hit
else #if not test -z "$ansied"
set hit_output "$hit_output"(set_color normal)"; "$ansied #add lines together just one in results
end
end #but this will all get wrecked by stupid fish_indent... fix source or workaround
end | eval (__fzfcmd) "$fzfopts" | read --array fzf_last_select #echo -ns $his\n | eval $colorcmd
test $fzf_last_select[1] #debug "fzf selection: %s" $fzf_last_select
and commandline -- "$fzf_last_select" #and if test (count (commandline -o)) -gt 2; commandline -rb -- (string join -- " " (commandline -o)[3..-1]); end #>2 tok use 3..last if inline timestamps
commandline -f repaint
end
