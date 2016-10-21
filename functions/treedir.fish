function treedir --description 'runs tree on all subdirs'
	for dir in (ls .)
        if test -d $dir
            command tree -Cax -L 3 --filelimit 15 -d --noreport $argv $dir
        end
    end
end
