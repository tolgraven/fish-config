function latest --description 'show x most recently modified files, default 5' --argument numshow
	set -l output (latr)
    test -z "$output"
    and return 1
    test -z "$numshow"
    and set numshow 5
    test (count $output) -lt 5
    and set numshow (count $output)
    set numshow (math "$numshow*-1")
    echo -ns $output[$numshow..-1]\n
end
