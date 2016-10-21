function raspemu
	qemu-system-arm -name "Raspberry Pi" -kernel ~/Documents/CODE/rpi/kernel-qemu-emulator -cpu arm1176 -m 256 -M versatilepb -serial stdio -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" -drive file=$raspbian,index=0,media=disk,format=raw -net nic -net user,hostfwd=tcp::9022-:22,hostfwd=tcp::9080-:80
end
