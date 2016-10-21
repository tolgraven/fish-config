function wc-lr --description 'Recursively apply wc -l on the current directory'
	find . -type f -print0 | xargs -0 -I '{}' wc -l '{}' | awk '{total += $1} END {print total}'
end
