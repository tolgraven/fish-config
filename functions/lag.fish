function lag --argument la with automatic wildcards
test -z "$argv"
#and la
and return

set dir (dirname $argv)
set file (basename $argv)
#grc -es ls -lAhG $dir | grep $file
la $dir | grep $file
end
