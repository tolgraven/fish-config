function __tol_move_dir_up
	test (string length (pwd)) -gt 1
    and cd ..
    and sleep 0.1
    or begin
        echoerr -n -s (set_color red) "Hit top dir" (set_color normal) "."
        sleep 0.1
        echoerr -n -s "."
        sleep 0.1
        echoerr -n -s ". "
        sleep 0.1
    end
    commandline -f repaint
end
