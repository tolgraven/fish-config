function slap
	if test $USER = root
        echo "no root, shit's borken"
        return 1
    end
    if not test -z $argv
        touch $argv
    end
    command slap $argv
end
