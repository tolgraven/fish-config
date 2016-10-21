
# why shit b disappearin?
#source /usr/local/Cellar/fish/HEAD/share/fish/completions/brew.fish
source $__fish_datadir/completions/brew.fish

function __fish_brew_formulae
    #set -l formuladir (brew --repository homebrew/core) #/Library/Formula
    #set -l formulas (ls $formuladir/*.rb | sed 's/.rb$//' | sed "s|^$formuladir||")
    set -q __fish_brew_formulas
    or set -g __fish_brew_formulas (brew search)

    set -l search (commandline -t)
    test $search = "install"
    and set search ""
    set -l results (echo -sn $__fish_brew_formulas\n | string match -- "$search*")
    test (count $results) -lt 40
    and begin
        for line in (brew desc $results)
            set split (string split --max 1 -- ":" $line)
            echo -s $split[1] \t $split[2]
        end
    end
    or echo -sn $__fish_brew_formulas\n
end

# install
complete -c brew -n '__fish_brew_using_command install' -a '(__fish_brew_formulae)' -f
