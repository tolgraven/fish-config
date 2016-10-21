function __tol_desc_token --description 'List info about token under cursor'
	#set -l IFS #helps?? NO DONT TINK SO
    set val (commandline -t)
    not test -z $val
    and test $val = $__tol_latest_token ^&- #or 
    test (commandline -L) -gt 1
    and return 0 #throttle a bit...
    test (commandline -C) -gt 0 #and debug "looking up thingy  %s  cursor pos %s  over char %s full line %s" $val (commandline -C) (string sub -l 1 -s (commandline -C) (commandline )) (commandline)
    set -l output #if string match -q -r -- '-*' $val #sooo this matched everything apparently? lol... #return 0 #for now, should look up completions...  #end
    #if test (commandline --search-mode)  #debug "oh sweet search mode"  #set -q examples #or set examples 'commandline (commandline | fish_indent); commandline -f repaint' '(set_color brgreen)' '(brew desc $results)' 'prettyping' 'brew fart lunix enpeemem-pip-upon-ke-snazz'  #set output $examples  #set -e examples[-1] #get where we are and upcoming queue and show scrolling up from beneath as theyre coming  #end
    if test -d $val
        and not test -z $val
        set output (ls $val)
    else if test -f $val
        debug "hit file %s" $val
        set output (ls -lA $val | string replace "$HOME" '~' | string replace "Google Drive/Mackup" ".ln") #make more better info later
        test -s $val #; and test that not massive, and is text, and not a virus, etc
        and set output $output (head -n 12 $val | strip_empty_lines) #| ccat) #\'
    else if test -z $val
        debug "empty token at %s total length %s" (commandline -C) (string length (commandline))
        if test (commandline -C) -ne (string length (commandline)) #set dir (pwd)  #and set output (ls $dir)
        end
    else
        set dir (dirname $val)
        if test $dir != . -a -d $dir
            set output (ls $dir)
        else if type -q $val
            if functions -q $val
                set -l header (functions $val)[1]
                string match -q -- "--argument" $header
                and set header (string split -- "--argument" "$header")
                set output (echo -s -n $header\n | fish_indent) #--ansi) #(functions_get_desc $val) \n $header[-1])
                set output (string split -- "--" $output) #| read -a output
            else
                set -l tldr (ls ~/.tldrc/tldr-master/pages/{common,osx} | grep -q $val; and tldr $val) #(tldr $val)
                if test (count $tldr) -gt 2
                    set output (echo -n -s $tldr\n | strip_ansi_color | strip_empty_lines) #$tldr[3..-1]\n | string trim)
                else
                    set output (type $val | strip_empty_lines | fish_indent) # --ansi)
                end
            end
        else
            test (string sub -l 1 $val) = \$
            and set nodollar (string sub -s 2 $val)
            or set nodollar $val
            debug "token without dollar:  %s" $nodollar
            set -q $nodollar
            and if test (count $$nodollar) -ne 0 #if set -q $nodollar #set -q $val
                debug "count:  %s" (count $$nodollar) #set parts; for line in $$nodollar; set parts $parts $line; end
                set -l -- parts $$nodollar
                debug "token with content: %s" $parts #\$$val
                set output (echo -n -s "Variable with contents:" \n$parts) #| fish_indent --ansi)
                set output $parts #(echo -n -s \n$parts) #| fish_indent --ansi)
            end ##EVAL, SHOW, EDIT that's what you can do. so f.ex. add instant interactive vared np, so basically can run functions as you're writing
            or begin
                debug "try complete %s" $val
                set output (set output (complete --do-complete -- $val); for line in $output; echo (string split \t $line)[1]; end)
                #string match -q -r '*__*__*' $output[1] #and set -l i 1  #and for line in $output #transform autojump dirs more palatable...
                #set output[$i] (echo -n -s (string split -m 2 '/' $line)[2] | string replace $HOME '~')
            end
        end #EXPAND: w auto etc, could also if at end of line lookup last time run, exit status, result or whatever 
    end
    set -l outputcount (count $output)
    test $outputcount -gt 10
    and set output $output[1..10]
    test $outputcount -gt 0
    or return 1
    test "$output" != "$__tol_latest_token_desc"
    or return 0
    for i in (seq 1 $__tol_desc_last_count)
        tput dl1
    end #tput cuu1
    ##debug -- "outputcount is %s.   output is %s." $outputcount $output\n
    set -l curr (commandline)
    set -l pos (commandline -C) #tput ed #tput dl1 #hectic! #tput el1 
    if test $outputcount -eq 1
        set -l outputlen (string length $output[1]) #commandline -C 0 #tput hpa (math (tput col) - $outputlen - 3)
        debug "one line hit, length %s content %s" $outputlen $output[1] #commandline $output[1] #echo -s -n $output[1]
        tput cud 1
        tput hpa 0
        echoright $output[1] #commandline -f repaint #sleep 1
        tput cuu 1 #commandline $curr
        move_back_lines 1 0
    else if test $outputcount -gt 1
        debug "many line hit %s" $outputcount #set -l IFS #commandline -C 0 #echo -n -s $output\n #set -l prompt 'printf "%s > \n " (set_color green) $output[1]'  #set -l right_prompt '' #set -l right_prompt 'printf "%s > " $output[1] '
        set init (echo -n -s $output\n) #[2..-1]\n) #set init $output[2..-1]
        echo -s $init\n >>~/.config/tolcrap/desc_output
        tput civis
        tput cud 1 #commandline -f repaint
        tput hpa 0
        set longeststring 0
        for i in (seq 1 (count $init))
            test (string length -- $init[$i]) -gt $longeststring
            and set longeststring (string length -- $init[$i])
            debug "longeststring %s" $longeststring
        end
        echoright $init[1]
        echoright ""
        echoright $init[2..-1]
        #echo -n -s (
        #printf '%*s\n' (math (tput cols) - $longeststring - 8 ) $init[2..-1] #)
        tput cuu 2 #read --prompt "$prompt" --right-prompt "$right_prompt" -c (echoright $output[2..-1]) #(echo -n -s $init\n) farte #set -e IFS
        set -g __tol_read $init #set -g __tol_read $farte
        set -g __tol_desc_last_count (count $__tol_read)
        move_back_lines $__tol_desc_last_count 0 #(count $init) 0
        tput cnorm
    end #set -l stat $status #sleep 1; #tput sgr0
    commandline -C $pos
    commandline -f repaint
    set -g __tol_latest_token $val
    set -g __tol_latest_token_desc $output #fart
end
