function __tol_copy_pipe
	#commandline --cursor 0
    #commandline --insert "echo \'"
    commandline --cursor 100000
    commandline --insert " | strip_ansi_color | strip_empty_lines | pbcopy"
    #eval 
    #echo -n (commandline) | pbcopy
end
