function __fish_complete_command --description 'Complete using all available commands'
	set -l ctoken (commandline -ct)
    switch $ctoken
        case '*=*'
            set ctoken (string split "=" -- $ctoken)
            printf '%s\n' $ctoken[1]=(complete -C$ctoken[2])
        case '*'
            # *** TOL MOD ***
            debug "BE COMPLETIN"
            set funcargs (string split " " (string split -- "--argument " (functions $ctoken)[1])[2])
            test $funcargs -gt 0
            #and complete -c $ctoken -a 'echo -n -s __args__{$funcargs}'
            and for arg in $funcargs
                #echoerr FARTS
                complete -c $ctoken -a "$arg"
            end
            # ^^^ TOL MOD ^^^ wtf does it actually do? 
            complete -C$ctoken
    end
end
