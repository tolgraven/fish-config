function audio
	test -z $argv[1]
    and SwitchAudioSource -c
    and return

    if contains -- $argv "-a"
        set devices (SwitchAudioSource -a)
        set longestdevice (strlen_longest $devices\n)

        #and echo (echo -n -s $devices\n | grep --color=never input | string trim | string split --right --max 2 -- ' ' )[1] (set_color brgreen)(tput smso) "INPUT" (tput smso)
        set inputs (echo -n -s $devices\n | grep --color=never input)
        for in in $inputs
            #echo -sn (set_color brblue) (string split --right --max 1 -- ' ' $in)[1]
            #tput hpa (math $longestdevice - 9)
            echo -sn (set_color brgreen)(tput smso) "INPUT" (set_color normal)
            #tput hpa 
            echo -s (set_color brblue) (string split --right --max 1 -- ' ' $in)[1]
        end
        tput cuu (count $inputs)
        tput hpa 0
        set outputs (echo -n -s $devices\n | grep --color=never output)
        for out in $outputs
            tput hpa $longestdevice
            echo -sn (set_color brred)(tput smso) "OUTPUT" (set_color normal)
            tput hpa (math "$longestdevice + 6")
            echo -s (set_color red) (string split --right --max 1 -- ' ' $out)[1]
        end
        return
    end
    SwitchAudioSource $argv
end
