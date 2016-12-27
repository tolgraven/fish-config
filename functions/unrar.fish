function unrar
	#switch "$argv[1]"
    #case 'e' 't' 'l'
    #end
    if test -e "$argv[1]" #first arg is file = no switches 
        command unrar x $argv
    else
        command unrar $argv
    end
end
