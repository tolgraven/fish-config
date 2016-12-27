function toled --description 'Inline text editor built on fish funced' --argument file option
	set -l filename
    set -l opt
    set -l new false
    while set -q file
        switch $file
            case '-n' '--no-cat' '-B' '--no-backup'
                set opt $file
                set file $option #don't cat orig state to cmdline before opening editor
            case '-*'
                return 1
            case '*' '.*'
                if test -e $file
                    test -w $file
                    and set filename $file
                    or tint: red "File not writable"
                else
                    touch $file
                    and begin
                        set filename $file
                        set new true
                    end
                    or tint: red "Can't create file"
                    set opt "--no-cat" "--no-backup" $opt
                end
                set -e file
        end
    end
    #function early_exit --on-job-exit %self --inherit-variable filename
    #functions -e early_exit
    #debug "toled exit handler running"
    #tol_reload_key_bindings
    #end
    if test (count $filename) -ne 1 #fallback test
        tint: red "Someone fucked up"
        return 1
    end
    set -l IFS
    set -l init
    string match -q -- "indent" $option
    and set init (cat $filename | fish_indent)
    or set init (cat $filename)
    #if not contains -- $opt "-n" "--no-cat"; and not test -z $init
    #echo "Original file, for comparison while editing: " #nah skip these for now at least #cat $filename #| fish_indent --ansi
    #end
    set -l printname (/usr/local/bin/realpath --relative-base ~ $filename; or echo $filename) #where did the realpath wrapper func shipped with fish go?
    set -l prompt 'printf "<%s> \t\t %s\n " (set_color brgreen)"$printname"(set_color normal) (tput smso)"c-q exit, c-s save, no c-c."(tput rmso)'
    set -l right_prompt 'printf "%stoled%s editing %s%s%s"  \
(tput smso)(set_color cyan) (set_color normal)  (set_color brred)(tput smso) '$filename' (set_color normal)'

    toled_bind_mode
    while not set -q toled_exit
        read --prompt "$prompt" --right-prompt "$right_prompt" --command "$init" --mode-name "toled" --shell text
        #set -l IFS # Shadow IFS _again_ to avoid array splitting
        set init (echo $text)
    end
    tol_reload_key_bindings
    if not test $toled_exit = "save"
        echo "Editing aborted."
        test $new = "true"
        and type -q trash
        and trash $filename
        set -e toled_exit
        return
    end

    tint: blue "INNA TMPFILE," (tint: green "backing up and replacing") (tint: brred (bold: $filename))
    gcp --parents $filename ~/.cache/toled/backups(realpath $filename)
    or cp $filename {$filename}_BAK #(dirname $filename)/.(basename $filename)_BAK

    set -l output (echo -s -n $init\n | perl -pe 's/\e\[?.*?[\@-~]//g') # strip ansi color codes
    set -l prefix (string sub -l 6 -- $output[1])
    test "$prefix" = "echo '"
    or echoerr "broken, prefix: " $prefix
    if test (count $output) -gt 2 #BELOW REMOVING THE WRAPPER ADDED BY C-s binding in toled_bind_mode
        echo -n -s (string sub -s 7 $output[1])\n $output[2..-2]\n (string trim -r -c \' $output[-1]) >"$filename"
    else if test (count $output) -gt 1
        echo -n -s (string sub -s 7 $output[1])\n (string trim -r -c \' $output[-1]) >"$filename"
    else
        echo -n -s (string sub -s 7 $output[1] | string trim -r -c \' ) >"$filename"
    end
    set -e toled_exit
end
