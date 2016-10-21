function mancat --argument manpage grepfor extraopts
	test -z $grepfor #mm
    and set grepfor ""
    set colorizer "command ccat --color=always" "ccze -A" "pygmentize" "fish_indent --ansi" #more?
    #man -t $manpage | ps2ascii | command cat -s $extraopts | rmblank | ccze -A | cgrep --after-context=1 $grepfor
    man -t $manpage | ps2ascii | command cat -s $extraopts | rmblank | eval $colorizer[-1] | cgrep --after-context=1 $grepfor | cgrep -v -- "--" #| command cat -n
    #command ccat --color=always | grep --after-context=1 $grepfor | rmblank
    #| string trim -chars "\n\-\-" | string trim
end
