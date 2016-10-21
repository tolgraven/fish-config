function __tol_desc_token --description 'List info about token under cursor'
	set val (commandline -t) #set -l IFS #helps?? NO DONT TINK SO
    not test -z $val
    and test $val = $__tol_latest_token ^&- #or 
    test (commandline -L) -gt 1
    and return 0 #throttle a bit...
    test (commandline -C) -gt 0 #and debug "looking up thingy  %s  cursor pos %s  over char %s full line %s" $val (commandline -C) (string sub -l 1 -s (commandline -C) (commandline )) (commandline)
    set -l output
    switch $val
        case '-*'
            debug "hit tha doble %s" $val  #$debug_footer
            return 0 #or find completion for job yo
    end #if string match -q -r -- '-*' $val; #return 0 ; #end  #sooo this matched everything apparently? lol... 
    #if test (commandline --search-mode)  #debug "oh sweet search mode"  #set -q examples #or set examples 'commandline (commandline | fish_indent); commandline -f repaint' '(set_color brgreen)' '(brew desc $results)' 'prettyping' 'brew fart lunix enpeemem-pip-upon-ke-snazz'  #set output $examples  #set -e examples[-1] #get where we are and upcoming queue and show scrolling up from beneath as theyre coming  #end
    if test -d $val
        and not test -z $val
        set output (ls $val)
    else if test -f $val
        debug "hit file %s" $val  #$debug_footer
        set output (ls -lA $val | string replace "$HOME" '~' | string replace "Google Drive/Mackup" ".ln") #make more better info later
        test -s $val #; and test that not massive, and is text, and not a virus, etc
        and set output $output (head -n 12 $val | strip_empty_lines) #| ccat) #\'
    else if test -z $val
        debug "empty token at %s total length %s" (commandline -C) (string length (commandline))  #$debug_footer
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
                set output (echo -s -n $header\n | strip_empty_lines | fish_indent) #--ansi) #(functions_get_desc $val) \n $header[-1])
                set output (string split -- "--" $output | strip_ansi_color | strip_empty_lines) #| read -a output
                #### WHAT TO DO!!!!!
                ## look through function for other function calls and dynamically list related functions and programs. ALSO: look up like what vars are used >2-3 times, any global vars used/modified...
                # eventually: maybe build a database so can also show what other functions call that function. or which functions call a specific program.
                # could extend to looking through history and seeing what words are used together = are related. and associate so can sorta build a profile / search for anything and find everything that might be relevant
            else
                set -l tldr (ls ~/.tldrc/tldr-master/pages/{common,osx} | grep -q $val; and tldr $val) #(tldr $val)
                if test (count $tldr1) -gt 2
                    set output (echo -n -s $tldr\n | strip_ansi_color | strip_empty_lines) #$tldr[3..-1]\n | string trim)
                else
                    set output (type $val | strip_empty_lines | fish_indent) # --ansi)
                end
            end
        else
            test (string sub -l 1 $val) = \$
            and set nodollar (string sub -s 2 $val)
            or set nodollar $val
            debug "token without dollar:  %s" $nodollar  #$debug_footer
            set -q $nodollar
            and if test (count $$nodollar) -ne 0 # is var. TODO: look up eg what functions use/modify it.
                debug "count:  %s" (count $$nodollar)  #$debug_footer #set parts; for line in $$nodollar; set parts $parts $line; end
                set -l -- parts $$nodollar
                debug "token with content: %s" $parts  #$debug_footer #\$$val
                #set output (echo -n -s "Variable with contents:" \n$parts) #| fish_indent --ansi)
                set output $parts #(echo -n -s \n$parts) #| fish_indent --ansi) 
            end ##EVAL, SHOW, EDIT that's what you can do. so f.ex. add instant interactive vared np, so basically can run functions as you're writing
            or begin
                debug "try complete %s" $val  #$debug_footer
                set output (set output (complete --do-complete -- $val); for line in $output; echo (string split \t $line)[1]; end | strip_empty_lines) #think tldr broke now?
                #string match -q -r '*__*__*' $output[1] #and set -l i 1  #and for line in $output #transform autojump dirs more palatable...
                #set output[$i] (echo -n -s (string split -m 2 '/' $line)[2] | string replace $HOME '~')
            end
        end #EXPAND: w auto etc, could also if at end of line lookup last time run, exit status, result or whatever 
    end
    test (count $output) -gt 0
    and set -g __tol_latest_token $val
    and __tol_desc_token_printer $output
end
