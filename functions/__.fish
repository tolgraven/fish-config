function __ --description 'subtraction, wraps math'
	set -l count (count $argv)
	switch "$count"
		case 0
			return 1
		case 1
			math "0 - $argv[1]"
		case (seq 2 100)
			set -l result $argv[1]
			for arg in $argv[2..$count]
				set result (math "$result - $arg")
			end
			echo $result
	end
end
