function binded --description 'add keybind interactively'
	set bindings_file ~/.config/fish/functions/fish_user_key_bindings.fish
    echo (set_color brgreen)"Press keys - unused adds new binding - existing gets edited (ctrl-c doesnt work, )"

    fish_key_reader ^&- | read -l sample_bind
    #first is always best (-k instead of massive escape seq)
    set -l newkey (string escape -- (string split -- " " $sample_bind)[2])

    set -l binds (cat $bindings_file)
    if set -l current (ack -- $newkey $bindings_file) #(string match -r -- "$newkey" $binds)
        set index (command cat -n $bindings_file | ack $newkey | string split " ")[1]
        #(string split " " (string match -r --index -- "$current*" "$binds"))[1]
        and set full_line $binds[$index]
        debug "current match %s  at index %s" $current $index

        set bindcmd $full_line #(not test -z $current; and echo $full_line)
    else if set -l current (functions fish_default_key_bindings | ack -- $newkey)
        set bindcmd $current
    end
    test -z $bindcmd
    and set bindcmd (echo $sample_bind | string replace -- "'do something'" '')

    set -l rightprompt (__tol_make_ed_right_prompt "binded" brpurple (string escape "$newkey") brred)
    read --prompt '' --right-prompt "$rightprompt" --command $bindcmd --shell newbind

    if not test -z $index
        set binds[$index] $newbind
    else
        set binds[-1] $newbind
        set binds $binds end
    end
    echo -ns $binds\n >>"$bindings_file"
    and source "$bindings_file"
    and fish_user_key_bindings
end
