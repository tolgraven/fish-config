function deluge --description 'control deluge from fish commandline' --argument command argument
    test -z "$command"
    and set command "info"
    set -l deluge "/Applications/Deluge.app/Contents/MacOS/deluge-console"
    test "$command" = "p"
    and set command "pause"

    not pscc deluged >&- ^&-
    and deluged #is own func launching daemon backgrounded...
    switch "$command"
        case 'info'
            set -l output (eval $deluge $argv | string trim | strip_empty_lines | grep -v "ID: " | string replace --all 'Name:' (set_color -o blue)''(tput smso) | hide 'State: ' 'Seeds: ' 'Size: ' 'Tracker status: ' 'Progress: ' ' Speed' ' time')
            set output (echo -ns $output\n | string replace "Paused" (set_color -o -b brred black)"Paused " | string replace "Seeding Up:" (set_color -o -b green black)"Seeding "(set_color normal) | string replace "Downloading Down:" (set_color -o -b bryellow black)"Downloading " | string replace "Speed:" (tput smso)"Speed"(tput rmso) | string replace 'Up:' \t\t'Up:' | string replace 'Peers:' \t\t'Peers:' | string replace 'Active:' \t\t'Active:' | string replace 'Ratio:' \t\t'Ratio:' | string replace 'Availability:' \t'Avail:' | string replace 'Announce OK' \ \t\t'Announce OK' )
            echo -ns $output\n | tint '#' brblue | tint 'Ratio' brpurple | tint 'Down:' bryellow | tint 'Up:' brgreen | tint 'GiB' green | tint 'MiB' red | tint 'KiB' brgrey | tint '/' brblue | tint '\[' blue | tint '\]' blue | tint '~' purple | tint 'Error:' red | tint '%' brpurple | tint 'Announce OK' brgreen | tint 'Peers:' brblue | tint 'Avail:' blue

        case 'watch' 'w'
            function __exit --on-job-exit %self --on-signal SIGINT
                functions -e __exit
                tput rmcup
                tput cnorm
                commandline -f repaint
            end
            tput civis
            while true
                set output (deluge info) #takes tiny bit to get so refresh it before clearing scr
                tput smcup #clear
                echo -ns $output\n
                sleep 2
            end
        case 'c' 'clip' 'clipboard' 'm' 'magnet'
            deluge add (string escape (pbpaste))
        case 'del' 'pause' 'recheck' 'resume' 'rm' 'add' 'help' '*'
            eval $deluge $argv #eval $deluge (string escape "$argv") ^&-
            #sleep 0.1
            #deluge info
    end
end
