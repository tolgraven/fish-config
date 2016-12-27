function isint --description 'test if value is an integer'
	string match -r -q '^-?[0-9]+$' $argv
end
