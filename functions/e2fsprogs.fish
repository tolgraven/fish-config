function e2fsprogs
	sudo (brew --prefix e2fsprogs)/sbin/$argv[1] (test (count $argv) -gt 1; and echo $argv[2..-1])
end
