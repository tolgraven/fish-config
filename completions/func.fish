function __tol_func_completion
    set -l token (commandline -t)
    if test -z "$token"
        functions -a
        and return 0
    end
    for function in (functions -a | string match "*$token*") #hmm wildcard before, get dropped anyways?
        functions_get_desc $function "print_completion"
    end
end

complete -xc func -a '(__tol_func_completion)' -f
