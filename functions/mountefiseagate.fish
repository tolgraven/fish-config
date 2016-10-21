function mountefiseagate --argument disk
	not set -q disk
    and set disk (disks | grep MAINMAIN | string sub -l 10)"s1"

    diskutil mount -mountPoint ~/mnt/EFI-seagate $disk
end
