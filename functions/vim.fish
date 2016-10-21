function vim
	if type -q nvim
        command nvim $argv
        #itermprofileswitch "command nvim" vim $argv
    else
        itermprofileswitch "command vim" vim $argv
    end
end
