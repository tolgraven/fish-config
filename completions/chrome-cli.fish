complete -xc chrome-cli -n '__fish_use_subcommand' -a "help list info open close reload back forward activate presentation size position source execute version"
complete -xc chrome-cli -n '__fish_seen_subcommand_from list' -a 'windows tabs links'
complete -c chrome-cli -s "w" -d "address specific window"
complete -c chrome-cli -s "t" -d "address specific tab"
