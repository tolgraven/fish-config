function vim
    #if status --is-interactive
    if type -q nvim
        #command nvim $argv
        switch (profile)
            case 'vim*' 'hotkey*'
                debug "already vim profile %s, argv %s" (profile) $argv
                command nvim $argv
            case '*'
                itermprofileswitch "command nvim" vim $argv
        end
    else
        itermprofileswitch "command vim" vim $argv
    end
    #else
    #command vim $argv
    #end
    #cursor reset
end
