function varadd --description 'Append value argv[2...-1] to array-variable argv[1]' --no-scope-shadowing --argument var newvalues
	test -z "$newvalues"
    and return 1
    set -q $var
    or set -l scope "-g" #if doesnt already exist make it global or itll die dead
    set $scope $var $$var $argv[2..-1]
end
