function debug_notoken
	set -l token (commandline -t)
    if not contains -- $token $fish_debug
        and not contains -- !$token $fish_debug
        set -g fish_debug !$token $fish_debug
        debug "added ignore of token %s. current contents of fish_debug: %s" $token $fish_debug
    else if contains -- !$token $fish_debug

        set index (contains -i -- !$token $fish_debug)
        set -e fish_debug[$index]
        debug "removed ignore of token %s. current contents of fish_debug: %s" $token $fish_debug
    else if contains -- $token $fish_debug
        set index (contains -i -- $token $fish_debug)
        set fish_debug[$index] !$token
    end
end
