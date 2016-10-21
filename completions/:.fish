complete -xc : -a '(set abbrs (grep abbr ~/.config/fish/conf.d/abbr.fish | string replace "abbr " "")
for a in $abbrs
	echo -s (string split " " $a)[1] \t (string split --max 1 " " $a)[2]
end)'
