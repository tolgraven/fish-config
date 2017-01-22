function __tol_copy_pipe
    commandline --cursor 100000
    commandline --insert " | strip_ansi_color | strip_empty_lines | pbcopy"
end
