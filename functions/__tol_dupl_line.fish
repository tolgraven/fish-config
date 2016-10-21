function __tol_dupl_line
	#kill, paste back, go to start, go up, paste again. prob gaining line from the kill somehow? insert just wrecks it
    test -z (commandline)
    and return

    #set -l pos (commandline -C)
    commandline -f kill-whole-line
    commandline -f yank
    commandline -f beginning-of-line #commandline -f repaint #noneed
    if test (commandline --line) -gt 1
        commandline -f up-line
    else
        commandline -i \n
    end
    commandline -f yank
    #commandline -C $pos

    #set -l lineindex (commandline -L); set -l contents (commandline)[$lineindex]
    #commandline (string replace $contents $contents\n$contents (commandline))
end
