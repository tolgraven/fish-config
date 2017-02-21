complete -xc arred -n "__fish_use_subcommand" -a "(set | sed -e 's/ /'\t'/' | grep \')" #Array: /' | grep \')" 
complete -xc arred -n "not __fish_use_subcommand" -a '(set __the_array (commandline --tokenize)[2]; for key in $$__the_array; echo -s $key \t (contains -i $key $$__the_array); end)'

#complete -xc arred -n "__fish_use_subcommand" -a "(__arredcomplete)"
#function __arredcomplete
# set -g __arrays: for var in (set -n)
#   test (count $$var) -gt 1; and varadd __arrays $var; and echo -n -s $var \t "Array: " $$var\n
#end #end #todo: use index as description and/or sort by index instead of a-z 
