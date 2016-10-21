source ~/.local/share/fish/generated_completions/launchctl.fish

function __complete_launchctl
    for line in (launchctl help | grep --color=never "Subcommands:" --after-context 100 | grep -v "Subcommands:" | string trim)
        echo -ns (string trim (string split " " $line)[1]) \t
        echo (string trim (string split " " $line)[2..-1])
    end
end
complete -xc launchctl -n "__fish_use_subcommand" -a '(__complete_launchctl)'
