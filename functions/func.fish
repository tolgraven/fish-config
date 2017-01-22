function func --description 'edit and save function' --argument function force
    contains $function $__tol_func_editing
    and test -z "$force"
    and functions -q $function
    and echoerr "Already editing $function somewhere" #ideally would tell where, and/or what differs, hehe
    and return 1

    debug "editing function %s" $function
    set -l orig (mktemp)
    set -l new (mktemp)
    functions $function >$orig

    bind --erase "!"
    bind --erase "\$"
    set -U __tol_func_editing $__tol_func_editing $function
    set -U __tol_func_pid $__tol_func_pid %self
    # tolfunc $function #the actual editing part
    # and functions $function >$new

    # set -l newdef (tolfunc $function)
    # and echo -ns $newdef\n >$new
    tolfunc $function >$new

    while set -l index (contains -i $function $__tol_func_editing) #clears all instances for good measure, since we only got here if forced
        set -e __tol_func_editing[$index]
        set -e __tol_func_pid[$index]
    end
    tol_reload_key_bindings

    set -l longest (count (command cat $orig))
    test (count (command cat $new)) -gt $longest
    and set longest (count (command cat $new))
    if test -s "$orig" # -s = file non-zero, so existing function
        and not test -z (diff --ignore-space-change -q $orig $new ^&-) # q = output if diffs, not quiet

        echo -s (set_color brgreen) "saving edited function" (set_color normal)
        # funcsave $function
        cp $new ~/.config/fish/functions/$function.fish
        and source ~/.config/fish/functions/$function.fish
        #set -l diff (colordiff --minimal --ignore-case --ignore-all-space $orig $new | ack -v -- "---")
        #echo -n -s $diff\n; sleep 0.2; move_back_lines (count $diff); commandline -f repaint; echo | grep -Fxv (echo $new) # echo | sd $new
    else if not test -s $orig #if orig is zero
        and test (count (command cat $new | strip_empty_lines | grep -v function | grep -v end | string trim)) -gt 0 #and shit aint empty
        echo "Saving new function" $function
        # funcsave $function	
        cp $new ~/.config/fish/functions/$function.fish
        and source ~/.config/fish/functions/$function.fish
    else #no change, supposedly. but somehow gets here when doing funcmv gah
        move_back_and_kill_lines $longest 1.5 #count $orig
        echo -n -s (set_color red) "   no change detected, not saving" (set_color normal) "."
        sleep 0.1
        echo -n -s "."
        sleep 0.1
        echo -n -s "."
        sleep 0.3
        if not test -s $orig
            functions -e $function
        end
    end
end
