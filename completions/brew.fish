source $__fish_datadir/completions/brew.fish
function __fish_brew_formulae
    set -q __fish_brew_formulae; or set -g __fish_brew_formulae (brew search)
    set -q __fish_brew_installed; or set -g __fish_brew_installed (brew list)
    set -l search (commandline --current-token)
    set -l results (string match -- "$search*" $__fish_brew_formulae)
    test -z "$results"; and return

    set -l common (echo -ns $results\n | gsed -e 'N;s/^\(.*\).*\n\1.*/\1\n\1/;D')
    test (string length -- $common) -gt (string length -- $search)
    and set results $common #dont waste time looking up/passing multiple results since pager wont be shown
    set -l count (count $results)

    if test $count -gt 1 -a $count -lt 200
				set -l IFS :
        for line in (brew desc $results)
						echo $line | read name desc

            string match -q -- $name $__fish_brew_installed
            and set tick '📗 '; or set tick '' #second part since need to reset since last line
            echo -s $name \t $tick $desc
        end
    else if test $count -eq 1
        echo $results
    else
        echo -sn $__fish_brew_formulae\n
    end
end
function __fish_brew_installing_formula
    if __fish_brew_using_command install #or __fish_brew_using_command reinstall
        set -l tokens (commandline --tokenize)

        test (count $tokens) -ge 3 #brew + install + formula
        or return
        for candidate in $tokens[-1..3] #search backwards for first valid formula
            contains -- $candidate $__fish_brew_formulae
            and set formula $candidate
            and break
        end
        debug "formula: $formula"
        not test -z "$formula"
				and set -l IFS \t
        and for line in (__fish_brew_formula_options $formula)
						echo $line | read opt desc
            complete -c brew -n "contains -- $formula (commandline --tokenize)" -l "$opt" -d "🍺  $desc"
        end
    end
end
function __fish_brew_formula_options -a formula
        set -l opts (brew options $formula)
        test -z "$opts"
        and return
        set opts $opts[1..-2] #last line is empty
        for line in $opts
            string match -q -- '--*' $line
            and echo -ns $newline (string replace -- '--' '' $line) \t
            or echo -n (string trim -- "$line")" "
            set newline \n #so gets skipped first echo
        end
    end

complete -f -c brew -n '__fish_brew_using_command install' -a '(__fish_brew_formulae)'
complete -f -c brew -n '__fish_brew_installing_formula' -a ''
complete -f -c brew -n '__fish_brew_using_command info' -a '(__fish_brew_formulae)'
complete -f -c brew -n '__fish_brew_using_command search' -a '(__fish_brew_formulae)'
complete -f -c brew -n '__fish_brew_needs_command' -l reinstall -d 'Uninstall and then install formula'
complete -f -c brew -n '__fish_brew_using_command reinstall' -a '(__fish_brew_installed_formulas)'
