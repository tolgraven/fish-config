
function __tol_complete_pip
    echo (pip)[6..16]\n | string trim --left | string replace -r "\s*\s*\s" "\t"
end

complete -xc pip -n "__fish_use_subcommand" -a "(__tol_complete_pip)" #'(echo (pip)[6..16]\n | string trim --left | string replace -r "\s*\s*\s" "\t" )'
complete -xc pip -n '(contains "install" (commandline -o))' -a '(for result in (pip search (commandline -t)); echo -s (string split " " $result)[1] \t (string split --right --max 1 $result)[-1]; end)'

function __fish_complete_pip
    set -lx COMP_WORDS (commandline -o) ""
    set -lx COMP_CWORD (math (contains -i -- (commandline -t) $COMP_WORDS)-1)
    set -lx PIP_AUTO_COMPLETE 1
    string split \  -- (eval $COMP_WORDS[1])

end
#complete -fa "(__fish_complete_pip)" -c pip
