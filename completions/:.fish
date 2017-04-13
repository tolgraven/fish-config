complete -xc : -a '(set abbrs (grep abbr $tol_fish_abbr_file | string replace "abbr " "")
for a in $abbrs
	echo -s (string split " " $a)[1] \t (string trim -c "\'" (string split --max 1 " " $a)[2])
end)'
