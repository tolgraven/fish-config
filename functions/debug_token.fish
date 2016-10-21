function debug_token
	set -l token (commandline -t)
    if not contains -- $token $fish_debug
        set -g fish_debug $token $fish_debug
        debug "added token %s. current contents of fish_debug: %s" $token $fish_debug
    else
        set index (contains -i -- $token $fish_debug)
        set -e fish_debug[$index]
        debug "removed token %s current contents of fish_debug: %s" $token $fish_debug
    end
end
