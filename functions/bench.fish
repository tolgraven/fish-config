function bench
	geekbench --benchmark --no-upload --arch 64bit | ccze --raw-ansi
    echo \n"Bench took" $CMD_DURATION \n
end
