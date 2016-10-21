function jarred --description 'edit array variables in inline editor, each index on its own line'
	set -l arrayname

    while set -q argv[1]
        switch $argv[1]
            case -h --help
                tint: blue (bold: "This is cool shit right?")
                return 0
            case '-*'
                echo (tint: red "Unknown option" (tint: blue $argv[1]))
                return 1
            case '*' '.*'
                if test -e $argv[1]
                    set filename $argv[1]
                else
                    touch $argv[1]
                    and set filename $argv[1]
                    or echo (tint: red "Can't create file")
                end
        end
        set -e argv[1]
    end

    #fallback test
    if test (count $filename) -ne 1
        echo (tint: red "Someone fucked up")
        return 1
    end

    set -l IFS
    # Shadow IFS here to avoid array splitting in command substitution
    # ^^ do I need these?

    set -l init

    #if test -w $filename #check if file writable
    #set init (cat $filename | fish_indent --no-indent)
    #or set init (cat $filename)
    #else
    #tint: red "File not writable"
    #return 1
    #end

    set -l prompt 'printf "%s%s%s>\"\n  " (set_color green) '(realpath -z --relative-base ~ $filename; or $filename)' (set_color normal)'
    # Unshadow IFS since the fish_title breaks otherwise
    set -e IFS
    if read -p $prompt -c "$init" -s cmd
        # Shadow IFS _again_ to avoid array splitting in command substitution
        set -l IFS
        _ "LOOKS GOOD TO ME "
        set init (echo $cmd)
    end
    #return 0

    set tmpname (mktemp -t fish_joened.XXXXXXXXXX)
    echo $init >$tmpname
    tint: blue "I MADED A TMPFILE OF YOUR TEXTE "

    tint: green "Writing it back to original file "
    echo (tint: brred (bold: "$filename"))
    set -l stat $status
    #cat $tmpname
    cat $tmpname >$filename
    rm -f $tmpname >/dev/null
    return $status
end
