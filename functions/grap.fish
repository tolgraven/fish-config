function grap --description 'grap cmd1 string2 is like cmd1 | ccat | grep string2'
	eval $argv[1] | ccat | grep $argv[2]
end
