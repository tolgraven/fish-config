function craptest --description 'edit and save function' --argument function
	debug "editing func" $argv
    bind --erase "!"
    bind --erase "\$"
    auto_desc tempoff
    set -l orig
    set -l new (mktemp)
    functions $argv >$orig #tput sc
    tolfunc $argv
    and funcat $argv >$new
    #tput csr
    set -l longest (count (cat $orig))
    test (count (cat $new)) -gt $longest
    and set longest (count (cat $new))
    #debug "rows: %s" $longest
    if not test -z (diff -q $orig $new ^&-)
        move_back_and_kill_lines $longest 0.5
        echo -s -n (set_color brgreen) "saving edited function" (set_color normal)
        funcsave $argv
        set -l diff (colordiff --minimal --ignore-case --ignore-all-space $orig $new | ack -v -- "---")
        echo -n -s $diff\n
        sleep 0.2
        move_back_lines (count $diff)
        commandline -f repaint
        #echo|grep -Fxv (echo $new) # echo | sd $new #sd diff f stdin-out 'comm also works.but color
    else
        move_back_and_kill_lines $longest 1.5 #count $orig
        echo -n -s (set_color red) "   no change detected, not saving" (set_color normal) "."
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
