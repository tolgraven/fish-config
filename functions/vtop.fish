function vtop
	test -z $argv[1]
    and set argv "--theme=seti"
    #echo $argv
    command vtop $argv
end
