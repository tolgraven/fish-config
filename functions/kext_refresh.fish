function kext_refresh
	sudo touch /System/Library/Extensions
    and sudo kextcache -U /
end
