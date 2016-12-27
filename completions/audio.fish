complete -xc audio -n "__fish_use_subcommand" -a "-a -c -t -n -s"
complete -xc audio -a '(SwitchAudioSource -a | grep -v "(input)" | grep -v "Instant On" | string replace " (output)" "")'
complete -c audio -s a -d "list devices"
complete -c audio -s c -d "show current"
complete -c audio -s t -d "set type" -a "input\n output\n system"
complete -c audio -s n -d "next device"
complete -c audio -s s -d "out" -a '(SwitchAudioSource -a | grep -v "(input)" | grep -v "Instant On" | string replace " (output)" "")'
