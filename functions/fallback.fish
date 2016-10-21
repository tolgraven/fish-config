function fallback --description 'fallback if var unset' --argument fallback expandervar
	test -z $fallback
    and return 1
    not test -z $expandedvar
    and echo $expandedvar
    or echo $fallback
end
