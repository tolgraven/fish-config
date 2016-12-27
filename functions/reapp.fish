function reapp --description 'kill app, then relaunch' --argument process
	k $process >&- ^&-
    sleep 0.1
    #type -q $process
    #and eval $process
    open -a $process
    #pkill
end
