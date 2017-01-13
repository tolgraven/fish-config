function hostsup
    set results (nmap -sP 192.168.1.\*) #(spin "nmap -sP 192.168.1.\*")
    test (count $results) -gt 3
    and set count (math (count $results[3..-3]) )
    or return

    set -l seq (seq 3 2 $count) #ugh incr is 2nd arg not 3rd, retarded
    debug $seq

    echo $results[2] | highlight #header
    for i in $seq #two lines each iteration, stop at last host ie third line from end...
        echo -s (string replace "Nmap scan report for " \t $results[$i]) (string replace "Host is up (" \t\t $results[ (math $i + 1) ] | string replace " latency)." \t)

    end
    echo $results[-1] | highlight #| ccze - A
end
