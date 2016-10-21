function k --description 'unified kill omnibus' --argument app
	if test -z "$app"
        #jobs
        return 1
    end
    psc $app
    if test "$argv[-1]" -gt 0 #if number... why last element here? haha
        kill $argv
        sleep 1
        psc $argv >/dev/null
        and kill -9 $argv
    else
        pkill $argv
        sleep 0.1
        psc $argv >/dev/null
        and pkill -9 $argv #or doesnt work since it doesnt actually fail...
        #still need to sort that it doesnt fetch ignoring case right?
    end
    set -l stat $status
    set -l remain (psc $argv[-1])
    not test -z "$remain"
    and echo -ns $remain\n
    return $stat
end
