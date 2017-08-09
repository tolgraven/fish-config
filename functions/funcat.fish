function funcat --description 'cat a function, with fun colors'
    test -z "$argv"; or not functions -q $argv; and return 1
    if isatty stdout;  and status is-interactive
        set color "--ansi"
    else
        set hide
    end

    set output (functions $argv | fish_indent $color)
    if set -q hide
        debug "filter out first junk line from $argv"
        echo -ns $output[2..-1]\n
    else
        echo -ns $output\n | string replace --all '    ' '  '
    end
end
