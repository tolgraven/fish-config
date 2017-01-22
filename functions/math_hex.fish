function math_hex --argument hexnum change
	test -z "$hexnum"
    and return
    test -z "$change"
    and set change "+1"

    echo "obase=ibase=16;$hexnum$change" | bc
end
