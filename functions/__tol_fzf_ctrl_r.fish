function __tol_fzf_ctrl_r
type -q fzf
or return 1
set colorcmd "fish_indent --ansi --no-indent"

set linenr (commandline --line)
set cmdline (commandline | string split "\n")
set cmdline (string trim -- "$cmdline[$linenr]")
test -z "$cmdline" #just quote and these wont need redir to avoid spewing, dummy
and set cmdquery ""
or set cmdquery "-q '$cmdline'\ " #prepopulate search. wasnt working before with multiple words bc hadnt quoted
#debug "linenr %s, cmdquery %s" -- $linenr $cmdquery

set -l preview 'history search --show-time --exact {} | fish_indent --ansi'
set -l fzfopts "--no-sort +m --toggle-sort=ctrl-r --preview='$preview' --preview-window=down:3:wrap \
--bind 'alt-p:toggle-preview,alt-enter:execute:/usr/local/bin/fish -c {}' $cmdquery"
set -l fish_term24bit 0

debug -- "normal fzf window %s %s %s" $colorcmd $cmdline $fzfopts
if test -z "$cmdline"
set hist (history)
set histsize (count $hist)
set incr 10000
if test $histsize -gt $incr
set from 1
set to $incr
while test $to -ne $histsize #debug "from %s, to %s, incr %s" $from $to $incr
set lines $lines (echo -ns $hist[$from..$to]\n | fish_indent --ansi --no-indent)

set from (math "$to+1")
set to (math "$to+$incr")
test $to -gt $histsize
and set to $histsize
end
echo -ns $lines\n | eval (__fzfcmd) "$fzfopts" | read --array fzf_last_select
end
else
history search --contains "$cmdline" | eval $colorcmd | eval (__fzfcmd) "$fzfopts" | read --array fzf_last_select
end

debug "fzf selection: %s" $fzf_last_select
test $fzf_last_select[1]
and commandline -rb -- "$fzf_last_select" #and if test (count (commandline -o)) -gt 2; commandline -rb -- (string join -- " " (commandline -o)[3..-1]); end #>2 tok use 3..last if inline timestamps

commandline -f repaint
end
