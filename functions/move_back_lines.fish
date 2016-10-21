function move_back_lines --argument lines time
	test -z $time
    and set time 0
    test -z $lines
    and set lines 1
    set perline (math $time / $lines)
    for i in (seq 1 $lines)
        #tput el1
        #tput el
        tput cuu1
        test $perline -gt 0
        and sleep $perline
    end
end
