function bindcat --description 'show key bindings' --argument grepfor
	switch "$grepfor"
        case '-i' #interactive
            echo "press n to exit, or any key combo to check binding"
            tput civis
            set allbinds (bind -k)
            while fish_key_reader ^&- | read sample_bind
                #set newkey (string escape -- (string split -- " " $sample_bind)[2])
                set newkey (string split -- " " $sample_bind)[2]
                test "$newkey" = '-k'
                and set newkey (string split -- " " $sample_bind)[3]
                debug "newkey: %s" "$newkey"

                test "$newkey" = 'n'
                and tput cnorm
                and return

                #set match_user (functions fish_user_key_bindings | string match "*$newkey*")
                #set match_default (functions fish_default_key_bindings | string match --ignore-case "*$newkey*" | string replace '$argv ' '' )
                #set matches $match_user $match_default
                set matches (string match --all --ignore-case "*$newkey*" $allbinds)

                echo -ns (set_color purple)$newkey(set_color normal)
                debug "nummatches: %s, matches: %s" (count $matches) $matches
                not test -z "$matches"
                and for line in $matches
                    set part (echo -ns (string split -- ' ' (string trim $line))[3..-1]\n | fish_indent --ansi) #drop 'bind \char' part..
                    echo \t $part #| fish_indent --ansi
                end
                or echo \t (set_color brred)"not bound" (set_color normal)
            end

    end

    set -l binds (bind -k | sort --ignore-case | fish_indent --ansi)
    test -z "$grepfor"
    and echo -ns $binds\n
    or echo -ns $binds\n | cgrep (string escape "$grepfor")
end
