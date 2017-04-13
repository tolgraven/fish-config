function + --description 'addition, wraps math'
test -z "$argv"
and return 1
set -l result 0
for arg in $argv
set result (math "$result + $arg")
end
echo $result
end
