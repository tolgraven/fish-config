complete -c ddcctl -s d -d "display" -a "(echo -n -s (ddcctl)[1..2] | string split '#' | string trim | read -a displays; for i in (seq 1 (count $displays)); echo -n -s $i \t $displays[$i] \n; end)" -f
complete -c ddcctl -s b -d "brightness" -a "(seq 1 100 20); echo '?'; echo '+'" -f
complete -c ddcctl -s c -d "contrast" -a "(seq 1 100 20)" -f
complete -c ddcctl -s h -d "help"

