complete -xc mos -n '__fish_use_subcommand' -a '(__complete_mos)'
function __complete_mos
    for line in (echo -ns (mos -h ^&1)[5..17]\n)
        set split (string split -- '  ' (string trim $line))
        echo -s (string trim -- $split[1]) \t (string trim -- $split[-1])
    end
end

