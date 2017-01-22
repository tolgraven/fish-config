function dot --description 'print dots fancy like' --argument num lines
    test -z "$lines"
    and set lines 1
    for i in (seq 1 $lines)
        __tol_echo_sleep "." $num
        echo
    end
end
