function docker-machine-completions
	if not set -q joen_dockermachine_completions
        set -l joen_dockermachine_completions (cat lines.txt)
    end
    for line in $joen_dockermachine_completion
        echo complete -c docker-machine -a (string split \t $line)[1] -d (string split \t $line)[-1] >> docker-machine.fish
    end
end
