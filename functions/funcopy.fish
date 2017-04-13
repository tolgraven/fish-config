function funcopy --argument orig new should_remove_old
functions -c $orig $new
funcsave $new
#func $new #not sure why I had this?
and if test $should_remove_old = "true"
or test $should_remove_old = "move"
pushd $fish_function_path[1]
trash $orig.fish
popd >&- #should also update completions if there are any itc
end
end
