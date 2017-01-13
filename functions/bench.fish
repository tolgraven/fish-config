function bench
    pauseall >&- ^&-
    set -l starttime (date +%s)
    fish -c 'geekbench --benchmark --no-upload --arch 64bit | highlight --style=zenburn --syntax=conf --out-format ansi #ccze --raw-ansi' & #way too much cpu...
    sleep 2
    rnice -20 "geekbench_x86_64" #geekbench
    fg >&- ^&-
    set -l benchtime (math (date +%s) - $starttime)

    echo \n (set_color brblue)"Bench took" $benchtime "seconds" #$CMD_DURATION \n
    contall >&- ^&-
end
