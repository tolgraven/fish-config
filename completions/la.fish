complete -c la -w ls
complete -c la -a '(for file in (set token (commandline --current-token); and ls -A $token ^&-); test -L $file; and echo -s $file \t "symlink"; or echo $file; end)'
