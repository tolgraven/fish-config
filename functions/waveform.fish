function waveform --description 'draw and potentially show waveform of a tune' --argument tune w h center outer bg output
	set -q tune
    or return 1
    test -z $w
    and set w 600
    test -z $h
    and set h 200
    test -z $center
    and set center AA08078A
    test -z $outer
    and set outer 0808CC03
    test -z $bg
    and set bg 030303AA
    if test -z $output
        set outfile "-" #stout..
        set output "| imgcat"
        #set outfile (mktemp)
        #and set output "imgcat"
    else if test (count $output) -gt 0
        and test (extname $output[1]) = "png"
        set outfile $output[1]
        set -e output
    end #hmm

    set cmd "command waveform '$tune' --width $w --height $h --color-center $center --color-outer $outer --color-bg $bg $outfile"
    debug "full parameters are:  %s" $cmd
    if test -z $output
        eval "$cmd"
    else
        eval "$cmd $output"
    end
end
