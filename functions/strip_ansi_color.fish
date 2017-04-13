function strip_ansi_color --description 'strip ansi escapes from input (piped or argument)'
if test -z "$argv"
while read -l line
echo $line | perl -pe 's/\e\[?.*?[\@-~]//g'
end
else
echo $argv | perl -pe 's/\e\[?.*?[\@-~]//g'
end
#not test -z $argv
#and perl -pe 's/\e\[?.*?[\@-~]//g'
#or echo $argv | perl -pe 's/\e\[?.*?[\@-~]//g'
end
