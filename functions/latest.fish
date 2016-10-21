function latest --description 'show x most recently modified files, default 5' --argument numshow
	set output (latr)
    test -z $numshow
    and set numshow 5
    test (count $output) -lt 5
    and set numshow (count $output)
    set numshow (math "$numshow*-1")
    echo -s -n $output[$numshow..-1]\n
end
