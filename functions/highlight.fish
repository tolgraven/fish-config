function highlight
	set -l params $argv
    if test -z "$argv[1]"
        set params --force --syntax=conf --out-format ansi
    else if not contains -- "--out-format" $argv
        set params --out-format ansi $argv
    else
        set params $argv #or command highlight $argv
    end

    test -z "$params"
    and set params --force --out-format ansi --syntax=conf
    not contains -- "--out-format" $params
    and set params --out-format ansi $params
    not string match -q -r -- '--syntax*' $params
    and set params "--syntax=conf" $params

    debug "argv: %s  params: %s  %s" -- $argv $params (count $params)
    command highlight $params
end
