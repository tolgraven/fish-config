function poppos
	if test (count $__tol_pos_stack) -eq 0
        return 1
    end
    debug "moving to row col %s" $__tol_pos_stack[1]
    string split " " $__tol_pos_stack[1] | read -l row col
    #tput cup (echo -n $__tol_pos_stack[1])
    tput cup $row $col
    #commandline -f repaint
    debug "row %d  col %d" $row $col
    set -e __tol_pos_stack[1]
end
