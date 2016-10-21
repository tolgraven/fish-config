function watch
	bind \cq "set -g watch_exit true" #; commandline -f execute"
    tput civis
    #tput smcup
    set -l lastoutput
    while not set -q watch_exit
        #echo \e\[H #clear?
        #du -h (ls -tr) | tail -20 | sed -e 's/^/\x1b\[K/' | cut -c -(math (tput cols) - 2)
        set output (du -h (ls -tr) | tail -20 | cut -c -(math (tput cols) - 2))
        if not string match $output $lastoutput
            clear
            echo -sn $output\n
            echo \e\[0J
        end
        sleep 2
        set lastoutput $output
    end
    set -e watch_exit
    tol_reload_key_bindings
    tput cnorm
    tput rmcup
end
