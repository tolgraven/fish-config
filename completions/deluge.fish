function __complete_deluge
    set -q __complete_deluge
    or set -g __complete_deluge (deluge help)[1..-3]

    for line in $__complete_deluge
        echo -n -s (string replace " - " \t $line) \n
    end
end
complete -xc deluge -n "__fish_use_subcommand" -a '(__complete_deluge)'
