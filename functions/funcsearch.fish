function funcsearch --description 'searches for text in all function definitions'
	for path in $fish_function_path

        set hits (searchtext "$argv" $path) #~/.config/fish/functions
        test (count $hits) -gt 0
        and echo $path:
        and echo -ns $hits\n
    end
    #set -l functions (functions -a)
    #for i in (seq 1 (count $functions))
    ##set __tol_funclist[$i] (functions functions[$i] | fish_indent --ansi | ack --context 3 $argv)
    #functions functions[$i] | fish_indent --ansi | ack --context 3 $argv
    #end
    ##echo -n $__tol_funclist\n
end
