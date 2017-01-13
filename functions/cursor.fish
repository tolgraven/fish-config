function cursor --description 'set cursor style in iterm' --argument type
    switch "$type"
        case block 0 normal vim
            echo -en '\e]50;CursorShape=0\x7'
        case underscore underline 2 _ 'under*'
            echo -en '\e]50;CursorShape=2\x7'
        case line \| 1 reset standard
            echo -en '\e]50;CursorShape=1\x7'
    end
end
