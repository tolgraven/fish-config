function math_hex --argument hexnum change
test -z "$hexnum"
and return
test -z "$change"
and set change "+1"
isint $change
and echo "put the operator, +- etc in the hex nums"
and return
set argv[2] $change


#echo "obase=ibase=16;$hexnum$change" | bc #outputs decimal
echo "obase=ibase=16;$hexnum$argv[2..-1]" | bc

end
