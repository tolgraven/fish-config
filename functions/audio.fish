function audio
    if test -z "$argv[1]"
        echo (SwitchAudioSource -c | string split "ASDSSSSS")[-1]

    else if contains -- $argv "-a"
        set devices (SwitchAudioSource -a | string split "ASDSSSSS")[-1]
        set longestdevice (strlen_longest $devices\n)

        set inputs (echo -n -s $devices\n | grep --color=never input)
        for in in $inputs
            echo -sn (set_color brgreen)(tput smso) "INPUT" (set_color normal) ' '
            echo -s (set_color brblue) (string split --right --max 1 -- ' ' $in)[1]
        end
        tput cuu (count $inputs)
        tput hpa 0

        set outputs (echo -n -s $devices\n | grep --color=never output)
        for out in $outputs
            tput hpa $longestdevice
            echo -sn (set_color brred)(tput smso) "OUTPUT" (set_color normal) ' '
            tput hpa (math "$longestdevice + 7")
            echo -s (set_color red) (string split --right --max 1 -- ' ' $out)[1]
        end

    else if test (count $argv) -eq 1
        and not string match -q -- '-*' $argv[1]
        SwitchAudioSource -s $argv | highlight #change device if just passing device
        #echo ERROR $argv
    else
        SwitchAudioSource $argv | highlight #| ccat
    end
end
