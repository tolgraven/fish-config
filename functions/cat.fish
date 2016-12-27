function cat
	if not contains -- '--force' $argv
        if not isatty 1 #regular if piped etc
            or status --is-command-substitution
            or not status --is-interactive
            debug "not interactive, passing through, args %s" $argv
            command cat $argv
            return $status
        end
    else
        set index (contains --index -- '--force' $argv)
        and set -e argv[$index]
    end

    test (count $argv) -gt 0
    and not string match -- '-*' $argv[-1]
    and if grep -q bplist00 $argv[-1]
        debug "binary plist, args %s" $argv
        cat (plutil -p $argv | psub)
        #plutil -p $argv | cat #broken by fish
        return $status
    else if not test -e $argv[-1] #not a file
        and string match -r -q -- 'http?://*' $argv[-1]
        #curl $argv[-1] | cat
        cat (curl --quiet $argv[-1] | psub)
        return $status
    end
    set -l ext (extname $argv[-1])
    and switch "$ext" #(extname $argv[-1]) #if test (extname $argv[-1]) = 'fish'
        case 'fish'
            debug "fish, args %s" $argv
            #or begin; not string match -- '-*' $argv[1]
            #and test (extname $argv[1]) = 'fish'; end
            ##isatty 1; and 
            set color "--ansi" #or set color ""

            test (count $argv) -eq 1
            and command cat $argv | fish_indent $color
            or command cat $argv[-1] | fish_indent $color | command cat $argv[1..-2]
            return $status
        case 'png' 'jpg' 'jpeg' 'gif' #else if string match --quiet -r -- 'png|jpg|jpeg|gif' (extname $argv[-1])
            debug "imgcat, args %s" $argv
            imgcat $argv[-1]
            return $status
        case '*'
            debug "highlight, args %s" $argv
            highlight $argv[-1] ^&-
            and return $status #continue to below if highlight throws silent error..
    end #else 
    if test -z "$argv"
        highlight #something is fucking broken in fish, piping to functions doesnt work anymore???
        debug "highlight, generic (piped)"
        return $status
    end
    if type -q vimcat
        debug "vimcat, args %s" $argv
        vimcat $argv #fix args in vimcat func instead?
    else if type -q ccat
        debug "ccat, args %s" $argv
        command cat $argv | ccat
    else
        debug "straight cat, args %s" $argv
        command cat $argv
    end
end
