function lag --argument la with automatic wildcards
	test -z $argv
    and la
    and return

    set dir (dirname $argv)
    set file (basename $argv)
    #grc -es ls -lAhG $dir | grep $file
    la $dir | grep $file

    #eval (echo $output | string replace $name (imgcat ~/Documents/CODE/OSX/tols/dir_small.png)$name )
end
