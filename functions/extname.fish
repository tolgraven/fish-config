function extname --description 'gets extension part of file, after last dot'
	#contains -- "-*" $argv
    #and return 1
    set part '-1'
    test (count $argv) -gt 0
    and switch $argv[1]
        case '-r' '--reverse'
            set part 1
        case '-*'
            #echoerr "NO KITTY THATS A BAD KITTY---"
            return 1
    end
    if not test -z $argv[-1]
        set -l output (string split -r -- . "$argv[-1]")
        echo $output[$part] #[-1]
    else
        echoerr "no output"
        return 1
    end
end
