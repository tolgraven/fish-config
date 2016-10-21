function diskutil
	command diskutil $argv | grep -v '#:' | cat
end
