function __tol_prepend_e_each_subgrep
	for word in (string split " " $argv)
        echo -n -s "-e $word "
    end
end
