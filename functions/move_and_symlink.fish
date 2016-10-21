function move_and_symlink --description 'move object to new path, symlink back to old path' --argument currpath newpath
	mv (string escape (dirname $currpath)/(basename $currpath)) (string escape $newpath)
    ln -s (string escape (dirname $newpath)/(basename $newpath)/(basename $currpath)) (string escape $currpath)
    #improvements: use rsync or something that shows progress. create move-to dir if doesn't exist. preserve full object path in new location but from new base.
    #check for existing files/links in new path. offer to overwrite or whatever.

    #reverse scenario should also be possible, unlink and move back...
end
