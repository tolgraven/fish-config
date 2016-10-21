function move_all_files_to_root_folder --description 'To current dir'
	for dir in (ls)
        if test -d $dir
            echo $dir
            and mv $dir/* ./
        end
    end
end
