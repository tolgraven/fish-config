function debug_token --description 'debug token under cursor, or passed as arg' --argument token
test -z "$token"
and set -l token (commandline -t)
test -z "$token"
and return

if not contains -- $token $fish_debug
set -g fish_debug $token $fish_debug
debug "added token %s. current contents of fish_debug: %s" $token $fish_debug
else
set index (contains -i -- $token $fish_debug)
set -e fish_debug[$index]
debug "removed token %s current contents of fish_debug: %s" $token $fish_debug
end
end
