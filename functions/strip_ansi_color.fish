function strip_ansi_color
	perl -pe 's/\e\[?.*?[\@-~]//g'
    #not test -z $argv
    #and perl -pe 's/\e\[?.*?[\@-~]//g'
    #or echo $argv | perl -pe 's/\e\[?.*?[\@-~]//g'
end
