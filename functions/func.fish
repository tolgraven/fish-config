function func --description 'edit and save function' --argument function force
    if contains $function $__tol_func_editing;  and test -z "$force";  and functions -q $function
        echoerr "Already editing $function somewhere";  return 1
    end #ideally would tell where, and/or what differs, hehe

    set -l orig (mktemp);  set -l new (mktemp)
    debug "editing function %s" $function
    funcat $function >$orig #better to stick to builtins but fish ofc fucked functions up ugh, use my wrapper

    bind --erase "!";  bind --erase "\$"
    set -U __tol_func_editing $__tol_func_editing $function;  set -U __tol_func_pid $__tol_func_pid %self

    tolfunc $function >$new;  or return 1 #havoc previously after bug in tolfunc since was continuing at this point...

    while set -l index (contains -i $function $__tol_func_editing) #clears all instances for good measure, since we only got here if forced
        set -e __tol_func_editing[$index];  set -e __tol_func_pid[$index]
    end;  tol_reload_key_bindings

    set -l longest (count (command cat $orig))
    test (count (command cat $new)) -gt $longest;  and set longest (count (command cat $new))
    if test -s "$orig" # -s = file non-zero, so existing function
        and not test -z (diff --ignore-space-change --ignore-all-space -q $orig $new ^&-) # q = output if diffs, not quiet

        echo -s (set_color brgreen) "saving edited function" (set_color normal)
        cp $new ~/.config/fish/functions/$function.fish;  and source ~/.config/fish/functions/$function.fish
    else if not test -s "$orig" #if orig is zero, new func
        and test (count (command cat $new | strip_empty_lines)) -ne 2

        echo "Saving new function" $function
        cp $new ~/.config/fish/functions/$function.fish;  and source ~/.config/fish/functions/$function.fish
    else #no change, supposedly. but somehow gets here when doing funcmv gah
        move_back_and_kill_lines $longest 0.5
        echo -n -s (set_color red) "   no change detected, not saving" (set_color normal) "."
        sleep 0.1;  echo -n -s ".";  sleep 0.1;  echo -n -s ".";  sleep 0.3
        not test -s $orig;  and functions -e $function
    end
end
