function strlen_longest --description 'get length of longest string passed' --argument array
	set -l longest_length 0
    set -l strings $argv
    test (count $strings) -gt 0

    and if test (count $strings) -gt 1
        for line in $strings
            set -l linelen (string length -- $line)
            test $longest_length -gt $linelen
            or begin
                debug -- "replaced longest line, new len %s  content %s" $linelen $line
                set longest_length (string length -- $line)
            end
        end
        and echo $longest_length
    else
        echo (string length $strings)
    end
end
