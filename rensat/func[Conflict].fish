function func --description 'edit and save function' --argument function
	debug "editing func" $function
    bind --erase "!"
    bind --erase "\$"
    #bind \cq set -g __quitter
    auto_desc tempoff
    set -l orig (mktemp)
    set -l new (mktemp)
    functions $function >$orig #tput sc
    tolfunc $function
    and functions $function >$new

    set -l longest (count (cat $orig))
    test (count (cat $new)) -gt $longest
    and set longest (count (cat $new))
    #debug "rows: %s" $longest
    echo "would you like to save?"
    set diffcmd diff
    type -q colordiff
    and set diffcmd colordiff
    if not test -s $orig
        funcsave $function
        echo \n "Saved new function" $function \n
    else if not test -z (diff --ignore-all-space -q $orig $new ^&-)
        move_back_and_kill_lines $longest 0.5
        echo -s -n (set_color brgreen) "saving edited function" (set_color normal)
        funcsave $argv
        set -l diff (eval $diffcmd --minimal --ignore-case --ignore-all-space $orig $new | ack -v -- "---")
        echo -n -s $diff\n
        sleep 0.2
        move_back_lines (count $diff)
        commandline -f repaint
        #|grep -Fxv (echo $new) #| sd $new #sd diff f stdin-out #comm also works,but color
    else
        move_back_and_kill_lines $longest 1.5 #count $orig
        echo -n -s (set_color red) "  no change detected, not saving" (set_color normal) "."
        sleep 0.1
        echo -n -s "."
        sleep 0.1
        echo -n -s "."
        sleep 0.3
        commandline -f repaint
    end
    tol_reload_key_bindings
    auto_desc tempoff
end
