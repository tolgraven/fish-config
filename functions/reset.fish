function reset
	tput rmcup
    tput cnorm
    #tput sgr0
    #command reset
    commandline -f repaint
    #sleep 0.1
    tol_reload_key_bindings
end
