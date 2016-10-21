function brightness_down
	not test -z $argv
    and set diff $argv
    or set diff 5
    brightness $diff -
    #test $brightness_main -gt 0
    #and brightness (math (echo $brightness_main)-$diff)
    #or echo 0
end
