function EXAMPLE_trap_sigint_ctrlc --description 'sleep for $argv seconds, supports ctrl-c mid-sleep'
	set time_to_sleep $argv
    set init $argv

    # set up a handler to be triggered if long_running_thing is cancelled mid-run
    function on_premature_exit --on-job-exit %self --inherit-variable time_to_sleep
        functions -e on_premature_exit # erase to prevent recursively calling itself when it exits
        debug "how i gets here at beginning of function?"
        echo "Cancelled editing var $init"
        #echo "Cancelled waiting for $time_to_sleep seconds"
    end

    # run the task
    #spin "sleep $time_to_sleep"
    read --command "$init" --shell butt
    echo "Did finish read $init $butt"
    #echo "Finished waiting for $time_to_sleep seconds"

    # erase the on_exit handler before exiting successfully
    functions -e on_premature_exit
end
