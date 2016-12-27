function bindcat --description 'show key bindings' --argument grepfor
	switch "$grepfor"
        case '-i' #interactive
            echo "press n to exit"
            while fish_key_reader ^&- | read sample_bind
                #set newkey (string escape -- (string split -- " " $sample_bind)[2])
                set newkey (string split -- " " $sample_bind)[2]
                debug "newkey: %s" "$newkey"
                test "$newkey" = 'n'
                and return
                #string match -r -- "$newkey" (functions fish_user_key_bindings) (functions fish_default_key_bindings | string replace '$argv' '')
                set matches (echo -ns (functions fish_user_key_bindings)\n (functions fish_default_key_bindings | string replace '$argv' '' | string match 'bind*')\n | command grep (string escape "$newkey"))
                echo -ns \n (set_color purple)$newkey(set_color normal):
                not test -z "$matches"
                and for line in $matches
                    echo -n \n (string split -- ' ' (string trim $line))[3..-1] | fish_indent --ansi #drop 'bind \char' part..
                end
                or echo -n (set_color brred) "not bound" (set_color normal)
            end

    end

    set -l binds (bind -k | sort --ignore-case | fish_indent --ansi)
    test -z "$grepfor"
    and echo -ns $binds\n
    or echo -ns $binds\n | cgrep (string escape "$grepfor")
end
