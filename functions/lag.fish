function lag
	test -z $argv
    and return
    set file (basename $argv)
    set dir (dirname $argv)
    #echo $dir
    #set hits (command ls $dir | grep $file ^&-) ^&-
    grc -es ls -lAhG $dir | cgrep $file

    #echo $hits

    #for hit in $hits
    #la $dir/$hit | cgrep $file # gets contents of hit if dir, instead of hit itself...
    #end

    #set output (la | grep --color=always $name)
    #eval (echo $output | string replace $name (imgcat ~/Documents/CODE/OSX/tols/dir_small.png)$name )
end
