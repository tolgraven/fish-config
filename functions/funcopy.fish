function funcopy --argument orig new should_remove_old
	functions -c $orig $new
    funcsave $new
    func $new
    and if test $should_remove_old = "true"
        or test $should_remove_old = "move"
        cd $fish_function_path[1]
        trash $orig.fish
        prevd >&- #should also update completions if there are any itc
    end
end
