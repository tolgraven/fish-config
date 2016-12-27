function lsg --description 'ls with automatic wildcard'
	test -z "$argv"
    and ls
    and return

    set file (basename $argv)
    set dir (dirname $argv)

    ls -A $dir | grep $file
end
