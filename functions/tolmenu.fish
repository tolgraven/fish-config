function tolmenu --description 'select and modify in-prompt' --argument list_func action_func autoerase
    test -z "$list_func"
    and set list_func ls -A
    test -z "$action_func"
    and set action_func "la"

    #tolmenu_fzf $list_func $action_func

    set -l cmdline (commandline)
    set -l cmdpos (commandline -C)
    tput civis
    tput cud1

    set -l slmenu_args -i -p ">>" -l 8
    echo -ns (eval $list_func)\n | slmenu $slmenu_args | read -l "choice"
    if not test -z "$choice"
        set choice (echo $choice | strip_ansi_color)
        set output (eval $action_func \"$choice\")
    else #esc leaks through
        commandline $cmdline
        commandline -C $cmdpos
    end
    tput hpa 0
    tput dl1
    tput cuu1
    tput dl1
    tput cuu1

    set outlines (echo -ns $output\n)
    echoright $outlines
    debug $outlines (count $outlines)
    not test -z "$autoerase"
    and for i in (seq 1 (math (count $outlines)+1 ))
        tput dl1 #clear line
        tput cuu1 #move line up
    end
    and tput el
    tput cnorm #show cursor
    commandline -f repaint
end
