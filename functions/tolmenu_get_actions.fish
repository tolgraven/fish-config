function tolmenu_get_actions --description 'echo available actions' --argument none
    for line in $tolmenu_actions
        set split (string split -- ':' $line)
        echo (set_color $split[1])$split[2](set_color normal)
    end
    #echo -n -s $tolmenu_actions \n
end
