function __complete_tmutil
    set -l complete_tmutil (tmutil | strip_empty_lines | string replace "Usage: " "" | string replace "tmutil " "" | string trim)
#    echoerr $complete_tmutil\n
    for i in (seq 1 (count $complete_tmutil))
        set -l split (string split " " $complete_tmutil[$i])
        echo -s $split[1] \t (test (count $split) -gt 1; and echo -n $split[2..-1]) #; or echo "choice, man")
        #        echoerr $i $split[1]
    end
end

complete -xc tmutil -a '(__complete_tmutil)' #'(set -l complete_tmutil (tmutil | strip_empty_lines | string replace "Usage: " "" | string trim); for i in (seq 1 (count $complete_tmutil)); set -l split (string split " " $complete_tmutil[i]); echo -s $split[2] \t $split[3..-1]; end)'
