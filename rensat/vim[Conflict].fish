function vim
	#itermprofileswitch "command mvimcli" vim $argv
    itermprofileswitch "command nvim" vim $argv ^&-
    or command vim $argv
end
