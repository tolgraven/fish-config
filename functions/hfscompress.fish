function hfscompress
	set -l command "afsctool -c -8 -v -s 4 -J16"
    #lvl8 from 1-9, verbose, min 4%, 16 concurrent threads incl I/O
    for file in $argv
        echo "$file":
        #functions -q spin >/dev/null
        #and spin (echo -n "$command" \"$file\")
        type -q ccat
        and set ccat "| command ccat"
        or set ccat ""
        eval (echo -n "$command" \"$file\") ^/dev/null $ccat
        echo
    end
end
