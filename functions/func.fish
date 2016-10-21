function func --description 'edit and save function' --argument function force
	contains $function $__tol_func_editing
    and test -z "$force"
    and functions -q $function
    and echoerr "Already editing $function somewhere" #ideally would tell where, and/or what differs, hehe
    and return 1

    debug "editing func" $function
    bind --erase "!"
    bind --erase "\$"
    #bind \cq set -g __quitter
    auto_desc tempoff
    set -l orig (mktemp)
    set -l new (mktemp)
    functions $function >$orig
    set -U __tol_func_editing $__tol_func_editing $function

    tolfunc $function # the actual editing part
    and funcat $function >$new

    while set -l index (contains -i $function $__tol_func_editing) #clear all instances since we only got here if forced
        set -e __tol_func_editing[$index]
    end

    set -l longest (count (command cat $orig))
    test (count (command cat $new)) -gt $longest
    and set longest (count (command cat $new))
    debug "rows: %s" $longest #echo "would you like to save?"
    if test -s "$orig" # -s = file non-zero
        and not test -z (diff --ignore-space-change -q $orig $new ^&-) #differs from orig (q = output if diffs, not quiet)

        if test "$force" = "quiet"
            set -l stat (funcsave $function)
            echo -n $function
            return $stat
        end
        #move_back_and_kill_lines $longest 0.5 #stop this part if curr func wasnt called from base level
        echo -s -n (set_color brgreen) "saving edited function" (set_color normal)
        funcsave $function
        #set -l diff (colordiff --minimal --ignore-case --ignore-all-space $orig $new | ack -v -- "---")
        #echo -n -s $diff\n
        #sleep 0.2
        #move_back_lines (count $diff)
        #commandline -f repaint
        #echo|grep -Fxv (echo $new) # echo | sd $new #sd diff f stdin-out 'comm also works.but color
    else if not test -s $orig #if orig is zero
        and test (count (command cat $new | grep -v function | grep -v end | string trim)) -gt 0 #and shit aint empty
        echo "Saving new function" $function
        funcsave $function
    else
        move_back_and_kill_lines $longest 1.5 #count $orig
        echo -n -s (set_color red) "   no change detected, not saving" (set_color normal) "."
        sleep 0.1
        echo -n -s "."
        sleep 0.1
        echo -n -s "."
        sleep 0.3
        commandline -f repaint
        if not test -s $orig
            functions -e $function
        end
    end
    tol_reload_key_bindings
    auto_desc tempoff
end
