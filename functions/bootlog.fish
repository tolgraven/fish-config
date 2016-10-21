function bootlog
	#cat /Library/Logs/CloverEFI/boot.log $argv
    bdmesg | ccat
end
