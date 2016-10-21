function cat
	if not contains -- '--force' $argv
        if not isatty 1 #regular if piped etc
            or status --is-command-substitution
            or not status --is-interactive
            command cat $argv
            return $status
        end
    else
        set index (contains --index -- '--force' $argv)
        set -e argv[$index]
    end

    test (count $argv) -gt 0
    and not string match -- '-*' $argv[-1]
    and if test (extname $argv[-1]) = 'fish'
        or begin
            not string match -- '-*' $argv[1]
            and test (extname $argv[1]) = 'fish'
        end
        #isatty 1; and 
        set color "--ansi" #or set color ""

        test (count $argv) -eq 1
        and command cat $argv | fish_indent $color
        or command cat $argv[-1] | fish_indent $color | command cat $argv[1..-2]
        return $status
    else if string match -- 'png|jpg|jpeg|gif' (extname $argv[-1])
        imgcat $argv[-1]
        return $status
    else if grep -q bplist00 $argv[-1]
        plutil -p $argv | cat
        return $status
    end

    if type -q vimcat
        vimcat $argv #fix args in vimcat func instead?
    else if type -q ccat
        command cat $argv | ccat
    else
        command cat $argv
    end
end
