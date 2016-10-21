function brightness_up
	not test -z $argv
    and set diff $argv
    or set diff 5
    brightness $diff +
    #test $brightness_main -lt 100
    #and brightness (math (echo $brightness_main)+$diff)
    #or echo 100
end
