function index --description 'get array index by content' --argument array search
	test -z $argv[1]
    and return 1
    contains --index -- $search* $array
end
