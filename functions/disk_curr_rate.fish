function disk_curr_rate --description 'get MB/s as of last sec for diskX (else disk0)' --argument disk
	test -z "$disk"
    and set disk "disk0"
    echo (string split " " -- (string trim (iostat -c 2 -d $disk)[4]))[-1]
end
