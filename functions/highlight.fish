function highlight
set -l params $argv
set -l theme --style gruvbox #bruvbox
#set -l common --out-format xterm256 --tab=2 $theme #no --failsafe because we want it to fail for cat wrapper, if it dunno
set -l common --out-format xterm256 --tab=2 #no --failsafe because we want it to fail for cat wrapper, if it dunno
if test -z "$argv" #if being piped so no file ext
set params --syntax=conf $common
else if not contains -- "--out-format" $argv
set params --out-format xterm256 $common $params
end
#highlight --out-format 

debug "argv: %s  params: %s  %s" -- $argv $params (count $params)
command highlight $params
end
