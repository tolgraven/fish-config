function binded --description 'add keybind interactively'
    set bindings_file ~/.config/fish/functions/fish_user_key_bindings.fish
    echo (set_color brgreen)"Press keys - unused adds new binding - existing gets edited (ctrl-c doesnt work, )"

    fish_key_reader ^&- | read -l bind
    set -l newkey (string escape -- (string split -- " " $bind)[2]) #first is best (-k instead of escape seq)
    #newkey has passed through string escape so dont need to do that again when using it later
    set -l bindcmd
    set -l index

    set -l binds (command cat "$bindings_file") #if set -l current (ack -- $newkey "$bindings_file") 
    ### HERE ACTUALLY NEEDS TO LOOK THROUGH bind -k first and match against that, so we are modifying the active binding...
    if set -l current (string match --ignore-case -r -- "$newkey" $binds)
        debug "found existing user binding %s" $current
        set index (command grep -i -n $newkey "$bindings_file" | string split ':')[1]

        isint $index
        and set bindcmd $binds[$index]

    else if set -l current (string match -r -- "$newkey" (functions fish_default_key_bindings | string replace '$argv' ''))
        debug "found existing default binding %s" $current
        set bindcmd $current
    end
    #debug "bindcmd: %s   numbinds: %s   index: %s" $bindcmd (count $binds) $index
    test -z "$bindcmd"
    and set bindcmd (echo $bind | string replace -- "'do something'" '')

    set -l rightprompt (__tol_make_ed_right_prompt "binded" brpurple (string escape "$newkey") brred)
    read --prompt '' --right-prompt "$rightprompt" --command "$bindcmd" --shell newbind

    if not test -z "$index" #replace existing line
        set binds[$index] $newbind
    else #add at end of file
        set binds[-1] $newbind
        set binds $binds end
    end
    cp "$bindings_file" ~/.config/fish/functions/deprecated/(basename "$bindings_file").BAK
    echo -ns $binds\n >"$bindings_file"
    and source "$bindings_file"
    and fish_user_key_bindings
end
