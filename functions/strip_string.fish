function strip_string --description 'remove string from text'
	#string escape | read -l --array text
    set -l IFS
    set -l i 0
    while read -l word #line
        set i (math 1 + (test "$i" -gt 0; and echo -n $i; or echo -n 0))
        #set text[$i] $word
        set text $text $word
    end
    debug "read %s words" $i
    for arg in $argv
        debug "replacing thing %s" $arg
        set text (string replace --all -- "$arg" '' $text ^&-) #| read text #^&-
    end
    debug "now have %s lines" (count $text\n)
    echo -ns "$text"
    #test
end
