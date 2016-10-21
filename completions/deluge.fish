function __complete_deluge
    set -q __complete_deluge
    or set -g __complete_deluge (deluge help_complete)[1..-3]
    #"add - Add a torrent
    #cache - Show information about the disk cache
    #config - Show and set configuration values
    #connect - Connect to a new deluge server.
    #debug - Enable and disable debugging
    #del - Remove a torrent
    #exit - Exit from the client.
    #halt - Shutdown the deluge server.
    #help - displays help on other commands
    #info - Show information about the torrents
    #pause - Pause a torrent
    #plugin - Manage plugins with this command
    #quit - Exit from the client.
    #recheck - Forces a recheck of the torrent data
    #resume - Resume a torrent
    #rm - Remove a torrent")

    for line in $__complete_deluge
        echo -n -s (string replace " - " \t $line) \n
    end
end
complete -xc deluge -n "__fish_use_subcommand" -a '(__complete_deluge)'
