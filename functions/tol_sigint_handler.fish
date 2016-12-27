function tol_sigint_handler --on-signal SIGINT
	set -l cmdline (commandline)
    set -l cmdpos (commandline -C)
    tol_reload_key_bindings #restore key bindings
    while set -l index (contains -i %self $__tol_func_pid) #unset is-editing funcs
        set -Ue __tol_func_editing[$index]
        set -Ue __tol_func_pid[$index]
    end
    tput cnorm #restore cursor
    tput rmcup #restore view

    profile reset #restore iterm profile
    commandline $cmdline
    commandline -C $cmdpos
    commandline -f repaint

    debug "received SIGINT pid %s" %self
end
