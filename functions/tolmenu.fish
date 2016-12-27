function tolmenu --description 'select and modify in-prompt' --argument list action autoerase
	test -z "$list"
    and set list ls -A
    test -z "$action"
    and set action "la"

    set -l cmdline (commandline)
    set -l cmdpos (commandline -C)
    tput sc #save pos
    tput civis #hide cursor
    tput cud1

    echo -s -n (eval $list)\n | slmenu -i -p ">>" | read -l "choice"
    if not test -z "$choice"
        set choice (echo $choice | strip_ansi_color)
        set output (eval $action \"$choice\")
    else #esc leaks through
        commandline $cmdline
        commandline -C $cmdpos
    end
    tput hpa 0
    tput dl1
    tput cuu1
    tput dl1
    tput cuu1

    set outlines (echo -n -s $output\n)

    echoright $outlines
    debug $outlines (count $outlines)

    not test -z $autoerase
    and for i in (seq 1 (math (count $outlines)+1 ))
        tput dl1 #clear line
        tput cuu1 #move line up
    end
    and tput el #tput cuu1 #tput rc #restore pos

    tput cnorm #show cursor
    commandline -f repaint
end
