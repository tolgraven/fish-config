function clone
	git clone (pbpaste) $argv | ccat
    cd (ls -t)[1]
end
