function auto_desc --argument state
	source ~/.config/fish/functions/__tol_bind_mode_hook.fish
    if test -z $state
        set -q tol_auto_describe
        and set -e tol_auto_describe
        or begin
            set -g tol_auto_describe
            set -g __tol_latest_token_desc "INIT"
            set -g __tol_latest_token "INNIT"
        end
    else
        switch $state
            case "on"
                set -g tol_auto_desc
            case "off"
                set -e tol_auto_desc
            case "tempoff" #should auto detect when it should stay away though... maybe just check how many lines prompt is?
                if set -q __tol_auto_describe_tempoff
                    set -e __tol_auto_describe_tempoff
                    set -g tol_auto_desc
                else
                    set -g __tol_auto_describe_tempoff
                    set -e tol_auto_desc
                end
        end
    end
end
