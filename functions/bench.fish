function bench
	#sudo nice -n -20 
    fish -c 'geekbench --benchmark --no-upload --arch 64bit | highlight --style=zenburn --syntax=conf --out-format ansi #ccze --raw-ansi' & #way too much cpu...
    sleep 2
    rnice -20 "geekbench_x86_64" #geekbench
    #fg
    #echo \n"Bench took" $CMD_DURATION \n
end
