function o
if not test -z "$argv"
open $argv >&- ^&-
or open -a $argv
else

open ./
end
end
