function watch_var -d "track var and show it continously in eg prompt" -a var
    test -z "$var"
    and set var (commandline -t)
    test -z "$var"
    or not set -q $var
    and return

    if not contains -- $var $tol_watch_var
        set -g tol_watchh_var $var $tol_watch_var
        debug "added var %s. current contents of tol_watch_var: %s" $var $tol_watch_var
    else
        set index (contains -i -- $var $tol_watch_var)
        set -e tol_watch_var[$index]
        debug "removed var %s. current contents of tol_watch_var: %s" $var $tol_watch_var
    end
end
