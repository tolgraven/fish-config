function deluge
	test -z $argv[1]
    and set argv "info"
    set -l dir "/Applications/Deluge.app/Contents/MacOS/"
    set -l deluge $dir"deluge-console"
    set -l deluged $dir"deluged"
    #set -l replace (echo -ns '"string replace "Paused" (set_color --bold --background brred black)"Paused"(set_color normal) | string replace "Seeding" (set_color --bold --background green normal)"Seeding"(set_color normal)"')

    if not pscc deluged >&- ^&- #eval $deluged &
        deluged
        and spin "sleep 2"
        debug "evaled %s" $deluged
    end
    switch $argv[1]
        case 'add'
            eval $deluge (string escape "$argv") ^&- #| cat; set -e argv[1]
            sleep 0.1
            deluge info
        case 'del' 'pause' 'recheck' 'resume' 'rm'
            eval $deluge $argv #| cat
            sleep 0.1
            deluge info #echo \n
            #eval $cmd info | ccze -A | string replace "Paused" (set_color --bold --background brred black)"Paused"(set_color normal) | string replace "Seeding" (set_color --bold --background green brgrey)"Seeding"(set_color normal)
        case 'info' 'help'
            eval $deluge $argv | ccze -A | string replace "Paused" (set_color --bold --background brred black)"Paused"(set_color normal) | string replace "Seeding" (set_color --bold --background green brgrey)"Seeding"(set_color normal) | string replace "Downloading" (tput smso)"Downloading"(tput rmso) | string replace "Speed:" (tput smso)"Speed'"(tput rmso) | string replace --all '#' (set_color brblue)'#'(set_color normal)
        case 'help_complete'
            eval $deluge help
        case 'watch'
            tput smcup
            while true #tput smcup
                set output (deluge info)
                clear
                echo -ns $output\n
                sleep 2
                #tput rmcup; sleep 1
            end
        case '*'
            eval $deluge $argv
    end
end
