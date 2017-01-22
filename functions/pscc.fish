function pscc
    set -l output (psc $argv command)
    not test -z "$output"
    and for line in $output
        string sub -l 360 $line #google lol
    end
    and return 0
end
