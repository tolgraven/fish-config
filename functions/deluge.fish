function deluge
    test -z "$argv[1]"
    and set argv "info"
    set -l dir "/Applications/Deluge.app/Contents/MacOS"
    set -l deluge $dir/"deluge-console"
    set -l deluged $dir/"deluged"

    if not pscc deluged >&- ^&-
        deluged
        and spin "sleep 2"
        debug "evaled %s" $deluged
    end
    switch "$argv[1]"
        case 'add'
            eval $deluge (string escape "$argv") ^&-
            sleep 0.1
            deluge info
        case 'del' 'pause' 'recheck' 'resume' 'rm'
            eval $deluge $argv
            sleep 0.1
            deluge info
        case 'p'
            test (count $argv) -gt 1
            and deluge pause $argv[2..-1]
        case 'info' 'help'
            set -l output (eval $deluge $argv | string trim | strip_empty_lines | grep -v "ID: " | string replace --all 'Name:' (set_color -o -b blue normal)\t | strip_string 'State: ' 'Seeds: ' 'Size: ' 'Tracker status: ' 'Progress: ' ' Speed' ' time') #| ccze -A)
            set output (echo -ns $output\n | string replace "Paused" (set_color -o -b brred black)"Paused " | string replace "Seeding Up:" (set_color -o -b green black)"Seeding " | string replace "Downloading Down:" (set_color -o -b bryellow black)"Downloading " | string replace "Speed:" (tput smso)"Speed"(tput rmso) | string replace 'Up:' \t\t'Up:' | string replace 'Peers:' \t\t'Peers:' | string replace 'Active:' \t\t'Active:' | string replace 'Ratio:' \t\t'Ratio:' | string replace 'Availability:' \t'Avail:' | string replace 'Announce OK' \ \t\t'Announce OK' )
            echo -ns $output\n | tint '#' brblue | tint 'Ratio' brpurple | tint 'Down:' bryellow | tint 'Up:' brgreen | tint 'GiB' green | tint 'MiB' red | tint 'KiB' brgrey | tint '/' brblue | tint '\[' blue | tint '\]' blue | tint '~' purple | tint 'Error:' red | tint '%' brpurple | tint 'Announce OK' brgreen | tint 'Peers:' brblue | tint 'Avail:' blue
        case 'help_complete'
            eval $deluge help
        case 'watch' 'w'
            function __exit --on-job-exit %self #--on-signal SIGINT 
                functions -e __exit
                tput rmcup
                commandline -f repaint
            end
            tput civis
            while true
                set output (deluge info)
                tput smcup #clear
                echo -ns $output\n
                sleep 2
            end
        case '*'
            eval $deluge $argv
    end #functions -e __exit
    debug end
end
