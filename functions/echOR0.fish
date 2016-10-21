function echOR0 --description 'echo var or 0' --argument var
	test -z $var
    and return 1
    set -q $var
    and echo $$var
    or echo 0
end
