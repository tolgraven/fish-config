complete -xc rnice -d "process" -a "(__fish_complete_proc | grep -v com.)" -f
complete -xc rnice -n "__fish_use_subcommand" -d "value" -a "-20 -15 -10 -5 0 5 10 15 20"
