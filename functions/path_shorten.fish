function path_shorten -d "shorten/restore paths for easier usage" -a path shorten_or_restore
    test -z "$shorten_or_restore"
    and set shorten_or_restore "shorten"
    test -z "$path"
    and set path (pwd) #or prob just error instead?


end
