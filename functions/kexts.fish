function kexts
	set -l userkexts (kextstat | grep -v com.apple)[2..-1]
    set -l seq (seq 1 (count $userkexts))
    for i in $seq #in $userkexts
        #set output (string trim (string sub -s 8 $output))

        set output (string split "0x" (string trim $userkexts[$i]))[-1]
        string sub -s 8 $output | string trim | read output

        set splitver (echo -s "<"(string split "<" $output)[-1])
        set output (string split "<" $output)[1]
        set output (string split " " $output)

        set namecol[$i] (echo -n $output[1]) # | ccat)

        #echo -n (set_color purple) $output[2] (set_color black)
        set vercol[$i] (echo -s (set_color brpurple) $output[2] \t (set_color black) $output[3] \t (set_color red) $splitver (set_color normal))
        #printf '%*s%s%s\t%s%s\t%s%s%s\n' (math "$COLUMNS-80") 
        #printf "\t\t\t%-100s\n" $right
        #set vercol[$i] (printf "%100s\n" $right)
    end
    set -l offset_vercol (strlen_longest $namecol\n)

    for i in $seq
        echo -s (echo -ns $namecol[$i] | ccat --color=always) (tput hpa (math $offset_vercol + 0)) $vercol[$i]
    end
end
