function substr --description 'trim string from start and/or end' --argument string trimstart trimend
	test -z $string
    and return 1
    not test -z $trimstart
    and set trimstart (math $trimstart +1)
    or set trimstart 1 #trim 0 = start 1
    test -z $trimend
    and set trimend 0

    string sub --start $trimstart --length (math (string length -- $string) - $trimend - $trimstart) -- $string
end
