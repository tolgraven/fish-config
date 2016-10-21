function echOR --description 'echo var, with fallback' --argument var fallback
	test -z $var
    and return 1
    set -q $var
    and echo $$var
    or echo $fallback
end
