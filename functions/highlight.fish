function highlight
    set -l params $argv
    if test -z "$params" #if being piped so no file ext
        set params --syntax=conf --out-format ansi #--force
    else if not contains -- "--out-format" $params
        set params --out-format ansi $params
    end


    debug "argv: %s  params: %s  %s" -- $argv $params (count $params)
    command highlight $params
end
