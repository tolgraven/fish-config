function oa
	test -z $argv
    and return 1
    open -a $argv
    or sfz "$argv" "open -a"
end
