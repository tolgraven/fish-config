
# why shit b disappearin?
#source /usr/local/Cellar/fish/HEAD/share/fish/completions/brew.fish
source $__fish_datadir/completions/brew.fish

function __fish_brew_formulae
    #set -l formuladir (brew --repository homebrew/core) #/Library/Formula
    #set -l formulas (ls $formuladir/*.rb | sed 's/.rb$//' | sed "s|^$formuladir||")
    set -q __fish_brew_formulas
    or set -g __fish_brew_formulas (brew search)

    set -l search (commandline -t)
    #    test $search = "install"
    #    string match -q -r -- 'install|search' $search
    #    test -z "$search"
    #    and set search ""
    set -l results (echo -sn $__fish_brew_formulas\n | string match -- "$search*")
    if test (count $results) -lt 50
        and not test -z "$results"
        set installed (brew list)
        for line in (brew desc $results)
            set split (string split --max 1 -- ":" $line)
            #            brew info $split[1] | not string match -q -- "Not installed"
            string match -q -- $split[1] $installed
            and set -l tick 📗  #👌 #' ✔'
            or set tick
            echo -s $split[1] \t $split[2] $tick
        end
    else
        echo -sn $__fish_brew_formulas\n
    end
end

# install
complete -c brew -n '__fish_brew_using_command install' -a '(__fish_brew_formulae)' -f
complete -c brew -n '__fish_brew_using_command search' -a '(__fish_brew_formulae)' -f
