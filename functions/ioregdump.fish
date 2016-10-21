function ioregdump
	ioreg -l -w0 -p IODeviceTree >~/Downloads/ioreg{$ioregcounter}.txt
    set ioregcounter (math $ioregcounter+1)
end
