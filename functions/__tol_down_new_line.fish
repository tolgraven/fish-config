function __tol_down_new_line
	commandline -f end-of-line
    #sleep 0.1



    commandline -i \n
    commandline -f force-repaint
    #commandline -f up-line #"cursor to new empty line"'
end
