function tol_prevd-or-backward-word
	set -l cmd (commandline)
    if test -z "$cmd"
        prevd
        commandline -f repaint
    else
        commandline -f backward-word
    end
end
