function source_completions --description 'source completions when extending at user-level' --argument completion
	for dir in $fish_complete_path[2..-1] #dont want to source our own obviously
        test -s $dir/$completion.fish
        and source $dir/$completion.fish
    end
end
