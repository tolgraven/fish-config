function path_transform --description 'shorten/restore paths for easier usage' --argument path shorten_or_restore
	test -z "$shorten_or_restore"
    and set shorten_or_restore "shorten"
    test -z "$path"
    and set path (pwd) #or prob just error instead?

	switch $shorten_or_restore
		case 'shorten'
			# set nocolor (echo $path | strip_ansi_color)
			
		case 'restore'

	end
end
