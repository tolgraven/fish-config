function setorset --description 'shorter set -q dance' --argument type var contents
	set -q $type #if var and not flag..
    and set contents $var
    and set var $type
    and set type '-g' #minimum to survive
    set -l count (set -q type; and echo 3; or echo 2)
    test (count $argv) -gt $count
    and set contents $argv[$count..-1]
    set -q $var
    or set $type $var $contents
end
