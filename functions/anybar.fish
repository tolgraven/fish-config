function anybar --description 'control anybar dot' --argument message instance
	set -l baseport 1738
    test -z $instance
    or test $instance -lt 1
    and set instance 1
    set -l offset (math $instance - 1)
    set -l port (math "$baseport + $offset")
    debug "sending message %s to instance %s port %s" $message $instance $port
    #todo: if setting status of non-running instance then start it...
    lsof -i :$port >&- ^&-
    or begin
        set -x ANYBAR_PORT $port
        debug "opening new instance at port %s" $ANYBAR_PORT
        open -na AnyBar
        sleep 0.1
        set -e ANYBAR_PORT
    end
    # was acting weird earlier bc my local netcat is gnu netcat...
    echo -n $argv[1] | /usr/bin/nc -4 -u -w0 localhost $port
end
