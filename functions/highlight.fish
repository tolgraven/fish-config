function highlight
set -l params $argv
set -l theme --style bruvbox #gruvbox
set -l common --out-format=xterm256 --tab=2 $theme #no --failsafe because we want it to fail for cat wrapper, if it dunno
set -l output
if test -z "$argv" #if being piped so no file ext
set params --syntax=conf $common
while read line
set output $output $line
end

#  else if not contains -- "--out-format" $params
else #dont need above check put in either way, any of common will get overridden by passed args anyways
set params $common $params
end

debug "argv: %s  params: %s  %s" -- $argv $params (count $params)
not test -z "$output"
and echo -ns $output\n | command highlight $params
or command highlight $params
end
