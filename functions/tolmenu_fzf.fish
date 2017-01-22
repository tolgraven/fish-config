function tolmenu_fzf --description 'tolmenu, but with fzf backend' --argument list_func action_func autoerase
    test -z "$list_func"
    and set list_func ls -A
    test -z "$action_func"
    and set action_func "la"

    set -l list (eval $list_func)
    set -l list_size (count $list)
    set -l fzf_opts "--height $list_size"
    debug "list_func %s, action_func %s, list_size %s, list %s, fzf_opts %s" $list_func $action_func $list_size "$list" "$fzf_opts"

    echo -ns $list\n | eval (__fzfcmd) $fzf_opts | read -l choice
    if not test -z "$choice"
        set output (eval $action_func \"$choice\")
    end
    echo -ns $output\n
    commandline -f repaint

    return
end
