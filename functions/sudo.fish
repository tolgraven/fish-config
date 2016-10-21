function sudo --description 'wrap sudo to call fish if function'
	#not test -z $argv[1]
    #and if functions -q $argv[1]
    #set argv fish -c "$argv"
    #end
    command sudo $argv
end
