function tolmenu_get_actions --description 'echo available actions' --argument none
    for line in $tolmenu_actions
        set split (string split -- ':' $line)
        set color (string trim -- $split[1])
        set action (string trim -- $split[2])
        echo (set_color $color)$action(set_color normal)
    end
end
