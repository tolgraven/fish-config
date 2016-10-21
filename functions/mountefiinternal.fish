function mountefiinternal
	diskutil mount /dev/disk0s1
    set -l prefix EFI #backlol #ESP #now for some reason
    #diskutil mount -mountPoint ~/mnt/EFI-internal/ /dev/disk0s1
    #open ~/mnt/EFI-internal/EFI/CLOVER/config.plist -a "Clover Configurator"
    open /Volumes/$prefix/EFI/CLOVER/config.plist -a "Clover Configurator"
    cd /Volumes/$prefix/EFI/CLOVER/
    o
end
