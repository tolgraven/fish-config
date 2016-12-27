function hostsup
	set results (spin "nmap -sP 192.168.1.\*") # | ccze -A)
    test (count $results) -gt 3
    and set count (math (count $results[3..-3]) )
    or return

    set -l seq (seq 3 2 $count) #ugh incr is 2nd arg not 3rd, retarded
    debug $seq

    echo $results[2] | ccze - A #header
    for i in $seq #(seq 3  2) #two lines each iteration, stop at last host ie third line from end...
        echo -s (string replace "Nmap scan report for " "" $results[$i]) (string replace "Host is up (" " " $results[ (math $i + 1) ] | string replace " latency)." "")

    end
    echo $results[-1] | ccze - A
end
