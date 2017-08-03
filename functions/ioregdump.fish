function ioregdump
not set -q ioregcounter
and set -U ioregcounter 0
set ioregfile ~/Downloads/ioreg{$ioregcounter}.txt
#  ioreg -f -l -w0 -p IODeviceTree >$ioregfile
ioreg -f -l -w0 >$ioregfile
set ioregcounter (math $ioregcounter+1)
vim -c "set ft=cfg" $ioregfile
end
