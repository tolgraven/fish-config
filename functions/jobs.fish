function jobs
    if status --is-interactive
        and isatty 1
        [ (builtin jobs -l | wc -l) -gt 0 ]
        and builtin jobs $argv | highlight | tint 'stopped' 'red'
    else
        builtin jobs $argv
    end
end
