function __tol_dirh_update --description 'update shared dirh stack' --on-variable PWD
	set -U tol_dirh $PWD $tol_dirh
    debug "curr dir count %s" (count $tol_dirh)

    echo -n $tol_dirh\n | uniq | read tol_dirh
    set -l count (count $tol_dirh)
    test $count -gt 10
    and set tol_dirh $tol_dirh[1..10]
end
