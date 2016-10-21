function mas --description 'mac app store' --argument command argument
	test -z $command
    and command mas
    or switch $command
        case 'search' 'list'
            set -l output (command mas $argv)
            for line in $output
                set line (string split --max 1 -- " " $line)
                set line (echo (set_color brblue)$line[1](set_color normal) \t (echo $line[2]))
                not test -z $argument
                and echo $line | cgrep $argument
                or echo $line
            end
        case '*'
            command mas $argv | cat
    end
end
