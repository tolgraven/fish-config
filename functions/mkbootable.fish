function mkbootable --description 'make volume bootable by osx' --argument volume
	bless --folder "$volume/System/Library/CoreServices" --bootinfo --bootefi
end
