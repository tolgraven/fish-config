function __complete_odrive
    set -q __complete_odrive
    or set -g __complete_odrive (echo '    authenticate        authenticate odrive with an auth key
    mount               mount remote odrive path to a local folder
    unmount             remove a mount
    backup              backup a local folder to a remote odrive path
    removebackup        remove a backup job
    sync                sync a placeholder
    stream              stream placholder/remote file eg. stream path "|" app. or stream to a file eg. stream path ">" file.ext
    refresh             refresh a folder
    unsync              unsync a file or a folder
    xlthreshold         split files larger than this threshold
    syncstate           get sync status info
    status              get status info
    deauthorize         deauthorize odrive to unlink the current user and exit
    emptytrash          empty odrive trash
    shutdown            shutdown odrive')
    debug "odrive comp count %s" (count $__complete_odrive)
    for line in $__complete_odrive
        set line (string split --max 2 " " (string trim $line) )
        set -l arg $line[1]
        set -l desc $line[2]
        debug "arg %s   desc %s" $arg $desc
        echo -s (string trim "$arg") \t (string trim "$desc")
    end

end

complete -xc odrive -n "__fish_use_subcommand" -a '(__complete_odrive)'
