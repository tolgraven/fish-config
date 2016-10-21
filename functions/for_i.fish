function for_i --argument count stuff
	test (count $argv) -gt 2
    and set stuff $argv[2..-1]

    for i in (seq 1 $count)
        eval "$stuff"
    end
end
