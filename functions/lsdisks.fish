function lsdisks
	diskutil list $argv | string replace --all "EFI" (set_color yellow)"EFI"(set_color normal) | string replace --all "GUID_partition_scheme" (set_color yellow)"GUID_partition_scheme"(set_color normal)
end
