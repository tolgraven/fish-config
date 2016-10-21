function __tol_rerun_last_command
	set -l cmdline $history[1] #$last_commandline
    if test -z $cmdline
        or not type -q (string split " " -- $cmdline)[1]
        echoerr -n "last line no good"
        sleep 0.25
        commandline -f repaint
        return 1
    end
    echo $cmdline | fish_indent --ansi

    commandline | read -l currcmd
    commandline -C | read -l currpos
    commandline $cmdline
    commandline -f repaint

    debug "commandline is %s" (commandline)

    eval (commandline)

    commandline $currcmd
    commandline -C $currpos
    commandline -f repaint
end
