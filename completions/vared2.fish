complete -xc vared2 -n "__fish_use_subcommand" -a "(set | sed -e 's/ /'\t'/' | grep \')"
complete -xc vared2 -n "not __fish_use_subcommand" -a '(set __the_array (commandline --tokenize)[2]; for key in $$__the_array; echo -s $key \t (contains -i $key $$__the_array); end)'
