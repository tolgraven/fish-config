function pscc
	set -l output (psc $argv command)
    not test -z "$output"
    #and echo -sn $output\n
    and for line in $output
        string sub -l 400 $line #google lol
    end
    and return 0
end
