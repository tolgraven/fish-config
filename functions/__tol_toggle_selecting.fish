function __tol_toggle_selecting --description 'toggle fish selection mode, or force on/off' --argument force
	test -z $force
    and set force "toggle"
    if test $force = "off"
        or test $force = "toggle"
        and set -q __tol_fish_selecting

        commandline -f end-selection
        set -e __tol_fish_selecting
        debug "select mode toggled off. force was %s" $force
    else
        commandline -f begin-selection
        set -g __tol_fish_selecting
        debug "select mode toggled on. force was %s" $force
    end
end
