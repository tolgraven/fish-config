function print --description 'echo contents of var properly formatted' --argument var
	if test -z "$var"
        echoerr "EMPTY VAR"
        return 1
        #else if not set -q $var
        #echoerr "NOT A VAR" $var
        #return 1
    end
    echo -ns $var\n
    echo -ns $$var\n
end
