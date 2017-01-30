function __tol_toggle_comment_commandline --description 'Comment/Uncomment the current line' --argument where
test -z "$where"
and set where "beginning"

if test "$where" = "beginning"
set -l cmdlines (commandline)
set -l linepos (commandline -L)
set -l buffpos (commandline -C)

set -l offset
for i in (seq 1 (count $cmdlines\n))
if test $i -eq $linepos
or set -q continues

set orig_len (string length -- $cmdlines[$i])
set cmdlines[$i] \#$cmdlines[$i]
set cmdlines[$i] (string replace -r '^##' '' $cmdlines[$i]) #what ^ thing does?
set offset (math $orig_len - (string length -- $cmdlines[$i]))

debug "hit, line %s, offset %s, content %s" $i $offset $cmdlines[$i]

set -e continues
#string match -- (string sub --length 1 --start (string length -- $cmdlines[$i])) \\ 
string match -- (string split "" -- $cmdlines[$i])[-1] \\
and set continues #test if line ends with \, comment next line
end
end

commandline -r $cmdlines
commandline -C (math $buffpos - $offset) #$buffpos
debug "change: %s" $change

else if test "$where" = end
commandline -f end-of-line
commandline -i ' # '
end
end
