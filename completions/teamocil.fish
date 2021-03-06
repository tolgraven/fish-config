complete -x -c teamocil -a '(teamocil --list)'
complete -c teamocil -l list -d "List all available layouts in `~/.teamocil/`"
complete -c teamocil -l here -d "Set up the first layout window in the current tmux window"
complete -c teamocil -l layout -d "Use a specific layout file, instead of `~/.teamocil/<layout>.yml`" -a '(ls ~/.teamocil | string replace ".yml" "\tlayout")'
complete -c teamocil -l edit -d "Edit the YAML layout file instead of using it"
complete -c teamocil -l show -d "Show the content of the layout file instead of executing it"
complete -c teamocil -l debug -d "Show the commands Teamocil will execute instead of actually executing them"
complete -c teamocil -l version -d "Show Teamocil’s version number"
