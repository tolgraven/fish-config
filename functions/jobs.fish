function jobs
	if status --is-interactive
        builtin jobs $argv | highlight | tint 'stopped' 'red'
    else
        builtin jobs $argv
    end
end
