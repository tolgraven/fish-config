function __complete_karabiner
    set -q __complete_karabiner
    or for line in (karabiner)
        string match -q -- '*Examples:*' $line
        and break
        set -g __complete_karabiner $__complete_karabiner $line
    end
    for line in (string trim $__complete_karabiner | string match -- '*$*' | string replace -- '$ karabiner ' '') #(karabiner | string match -- '*$*' | string trim | string replace -- '$ karabiner ' '')
        string match -q -- '*Examples:*' $line
        and break
        set split (string split ' ' $line)
        echo -s $split[1] \t (test (count $split) -gt 1; and echo $split[2..-1])
    end
end
complete -xc karabiner -a '(__complete_karabiner)'
