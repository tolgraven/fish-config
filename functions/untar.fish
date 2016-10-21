function untar
	tar xvf $argv
    cd (string split "." $argv)[1]
end
