function __tol_eval_job_and_sneak_peek --no-scope-shadowing
	#oh yeah no scope shadowing wont work bc parent func isnt actually calling hmm
    bind \n commandline\ -i\ \\n
    #bind \r commandline\ -i\ \\r

    set -l currpos (commandline -C)
    set -g __tol_saved_job (commandline -j)
    set -l job_text_length (string length $__tol_saved_job)
    #set -l currtoken (commandline -t)
    #set -l output (eval $__tol_saved_job)
    eval $__tol_saved_job | read -l output
    set -l output_text_length (string length $output)

    #test (count $output) -le 5 #else put in var and put that instead #and 
    commandline -j "echo -n \"$output\""
    and commandline -C -- (math $currpos - $job_text_length + $output_text_length + 10) # +10 for echo wrap
    ### would want to remove paranthesis around job after evaling it, or shit wont work. alt is to add echo and wrap... which would have to do when putting in var anyways, so maybe good?

    debug "result of %s is %s" $__tol_saved_job $output
    tol_reload_key_bindings

    commandline -f repaint
end
