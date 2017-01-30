function filter -d "grep auto add -e for every arg"
test -z "$argv"
and return 1
grep -i --color=always (for arg in $argv; echo " -e $arg"; end)
end
