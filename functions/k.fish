function k --description 'unified kill omnibus' --argument app
	if test -z "$app"
        #jobs
        debug "no process passed to kill..."
        return 1
    end
    psc $app
    if test "$argv[-1]" -gt 0 #if number... why last element here? haha
        kill $argv
        or sudo kill $argv
        sleep 3

        psc $argv >/dev/null
        and kill -9 $argv
    else
        pkill $argv
        or sudo pkill $argv
        sleep 3

        psc $argv >/dev/null
        and pkill -9 $argv #or doesnt work since it doesnt actually fail...
        or sudo pkill -9 $argv #still need to sort that it doesnt fetch ignoring case right?
    end
    set -l stat $status
    set -l remain (psc $argv[-1])
    not test -z "$remain"
    and echo -ns $remain\n
    return $stat
end
