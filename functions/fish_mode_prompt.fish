function fish_mode_prompt --description 'Displays the current mode'
	# Do nothing if not in vi mode
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
        switch $fish_bind_mode
            case default
                set_color --bold --background green white
                echo '  '
            case insert
                set_color --bold --background brblue white
                echo '  '
            case replace-one
                set_color --bold --background bryellow white
                echo '  '
            case visual
                set_color --bold --background brpurple white
                echo '  '
        end
        set_color normal
        #echo -n ' '
    end
end
