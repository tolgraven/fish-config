function fcd -d "Fuzzy change directory"
    set -q argv[1]
    and set searchdir $argv[1]
    or set searchdir $HOME
    # https://github.com/fish-shell/fish-shell/issues/1362 # set -l tmpfile (mktemp)
    find $searchdir \( ! -regex '.*/\..*' \) ! -name __pycache__ -type d | fzf | read -l result  #|> $tmpfile
    #set -l destdir (cat $tmpfile) #rm -f $tmpfile
    test -z "$result"
    and return 1
    test -d $result
    and cd $result
end
