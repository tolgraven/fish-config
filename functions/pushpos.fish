function pushpos
	curpos | read -l curpos
    set -g __tol_pos_stack $curpos $__tol_pos_stack
end
