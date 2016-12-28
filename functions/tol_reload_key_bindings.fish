function tol_reload_key_bindings --description 'Reload key bindings when binding variable change'
	# diff from __fish_reload_key_bindings: skips check, else same
    set -g __fish_active_key_bindings "$fish_key_bindings"
    set -g fish_bind_mode default
    if test "$fish_key_bindings" = fish_default_key_bindings
        fish_default_key_bindings
    else
        eval $fish_key_bindings ^/dev/null
    end
    # Load user key bindings if they are defined
    if type -q fish_user_key_bindings #functions --query fish_user_key_bindings >/dev/null
        fish_user_key_bindings
    end
end
