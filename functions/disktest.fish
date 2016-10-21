function disktest
	time dd if=/dev/zero bs=1024k of=tstfile count=(math "$argv * 1024"; or echo 1024) 2>& 1 | awk '/sec/ {print $1 / $5 / 1048576, "MB/sec out" }'
    and time dd if=tstfile bs=1024k of=/dev/null count=(math "$argv * 1024"; or echo 1024) 2>& 1 | awk '/sec/ {print $1 / $5 / 1048576, "MB/sec" }'
    rm tstfile
end
