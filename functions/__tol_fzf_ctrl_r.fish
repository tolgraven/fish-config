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

set -l preview "--preview='history search --show-time --exact (echo (string split \#\  {})[1] | string trim) | fish_indent --ansi'"
set -l fzfopts "--no-sort +m --toggle-sort=ctrl-r $preview --bind 'alt-enter:execute:/usr/local/bin/fish -c {}' $cmdquery"

if test -z "$cmdline" #debug -- "normal fzf window %s %s %s" $colorcmd $cmdline $fzfopts
set -l fish_term24bit 0 #cant use truecolor in fullscreen
set fzfopts $fzfopts "--preview-window=down:4:wrap" #fullscreen, bottom preview window
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
and set height '50%'
set fzfopts $fzfopts "--height=$height --reverse --preview-window=up:4:wrap" #inline, below prompt
set timestamp_len 26 #chars #set his (history search --contains "$cmdline")
set timestamp_col (math "$COLUMNS - $timestamp_len")
debug "cols: %s, timestamp offset: %s" $COLUMNS $timestamp_col
tput cud1
spin "sleep 5 &"
history search --show-time --contains "$cmdline" | while read line
switch "$line"
case '# M|T|W|F|S' '# *'
set -q timestamp #arriving again at new timestamp = flush last assembled
and printf "%s %*s"\n (string trim -r -c ';' -- "$hit_output") $timestamp_col (set_color $fish_color_comment)$timestamp(set_color normal)
#and printf "%s%s"\n (string trim -r -c ';' -- "$hit_output") (tput hpa $timestamp_col)(set_color $fish_color_comment)$timestamp(set_color normal)
#and echo -s (string trim -r -c ';' -- "$hit_output") (tput hpa $timestamp_col)(set_color $fish_color_comment)$timestamp(set_color normal)
#debug "out: %s" "$hit_output"
set timestamp $line
set new_hit
set outer
set hit_output
case '*'
#debug 'incoming line: %s' $line
set ansied (echo "$line" | eval $colorcmd) #echo "$line" | eval $colorcmd | read ansied #set ansied (echo $line | eval $colorcmd)
if test (count $ansied) -gt 2 #apparently spews an extra line so >2 == >1
#and debug "ansied %s lines, 1: %s, 2: %s" (count $ansied) $ansied[1] $ansied[2]
#and set ansied $ansied\; #reduce back anything fish_indent has seperated
for ansi in $ansied
set stripped (strip_ansi_color "$ansi" | strip_empty_lines | string trim)
not test -z "$stripped"
and set outer $outer (echo -ns $ansi ';')
end
else if not test -z "$ansied[1]"
set outer "$ansied[1]" #just grab the one good line
end
if set -q new_hit
set hit_output "$outer" #"$ansied" #grab ansi here so can keep own formatting etc
set -e new_hit
else #not timestamp but not new, so a multiline (in a seperate sense from fish_indents splitting)
#set hit_output "$hit_output"(set_color normal)"; "$ansied(set_color normal) #add lines together just one in results
set hit_output "$hit_output"(set_color normal)"$outer"(set_color normal) #add lines together just one in results
end
end #but this will all get wrecked by stupid fish_indent... fix source or workaround
end | eval (__fzfcmd) "$fzfopts" | read --array fzf_last_select
if test $fzf_last_select[1]
debug "got choice: %s" "$fzf_last_select"
set nostamp (string split '# ' "$fzf_last_select[1]")
set fzf_last_select $nostamp[1]
commandline -- "$fzf_last_select" #and if test (count (commandline -o)) -gt 2; commandline -rb -- (string join -- " " (commandline -o)[3..-1]); end #>2 tok use 3..last if inline timestamps
else
echo \n "WRONG WRONG WRONG" \n buuu
end
commandline -f repaint
end
