function __tol_edit_token --description 'edit contents of current token interactively, funced, vared, etc' --argument force
	set -l token (commandline -t)
    test -z "$token"
    and return 1
    set -l cmdpos (commandline -C)
    set -l cmdline (commandline)
    commandline ""
    set -l isarray

    if functions -q $token
        func $token $force
    else if set -q $token
        debug "var, no dollar %s" $token
        if test (count $$token) -eq 1
            vared $token
        else
            set isarray true #or commandline "arred $token "; and complete --do-complete
        end
    else if set -q (string sub -s 2 $token)
        debug "var, with dollar %s" $token
        set token (string sub -s 2 $token)
        if test (count $$token) -eq 1
            vared $token
        else
            set isarray true
        end
    else if test -f $token #file
        toled --no-cat $token
    else
        debug "unknown, creating function"
        func $token #maybe look up if it's a content of a var or array etc? and also check if index stuff and straight vared" #and if on a --thing can look up which token its completing and comped that hah
    end
    if not test -z $isarray
        set -l IFS #shadow before setting init so get sep lines in read later <- hmm ok but isnt it opposite?
        set init (echo -n $$token\n | fish_indent)
        set -l prompt ""
        set -l clocky (fish_right_prompt)
        set -l right_prompt 'printf "%s%s%s %s %s%s%s "   (tput smso)(set_color brred) "tolarred" (set_color normal) "editing" \
(set_color brgreen)(tput smso) "$token" (set_color normal) (tput smso)(string sub --start=-6 $clocky)(set_color normal)'

        set -e IFS #unshadow _before_ do read or splits every char
        read --prompt "$prompt" --right-prompt $right_prompt --array --shell newarray --command "$init"
        and set $token $newarray

        #echo $newarray >>~/.debug/__tol_edit_token-$token.log #commandline "arred $token "; and complete --do-complete
    end
    commandline $cmdline
    commandline -C $cmdpos
    commandline -f repaint
end
