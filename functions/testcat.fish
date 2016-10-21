function cat
    if test (extname $argv) = fish
        set color "--ansi"
        #status --is-command-substitution
        #status --is-interactive
        isatty 1
        or set color ""
        command cat $argv | fish_indent $color #(isatty 1; and echo $color; or echo "--ansi")
    else if type -q ccat
        #command ccat $argv
        command cat $argv | ccat
    else
        command cat $argv
    end
end
