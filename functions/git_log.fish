function git_log -d "pretty and condensed git log"
	echo -ns (git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr")\n
end
