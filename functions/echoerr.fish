function echoerr
#echo >&2 $argv #just redirects, doesnt write directly
#correct below
set -l IFS ' '
awk -v msg="$argv" 'BEGIN { print msg > "/dev/stderr" }'
end
