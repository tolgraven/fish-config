function compcat --description 'cat your completions, in full color'
	set -l completename
    set -l quiet
    while set -q argv[1]
        switch $argv[1]
            case -h --help
                echo "cat ur comps."\n"-q for quiet (only spit out completions so can redirect)"
                return 0
            case -q
                set quiet \#
                set completename $completename $argv[2]
                break
                echo $completename
            case '-*'
                printf (_ "%s: Unknown option %s\n") completed $argv[1]
                return 1
            case '*' '.*'
                set completename $completename $argv[1]
        end
        set -e argv[1]
    end
    if test (count $completename) -ne 1
        echo "complatename var: " $completename
        echo "compcat: You must specify something to cat comps for"
        return 1
    end
    set init
    set existingcompletions
    for i in (seq 1 (count $fish_complete_path))
        test -e $fish_complete_path[$i]/$completename.fish
        and varadd existingcompletions $fish_complete_path[$i]/$completename.fish
    end

    if type -q $completename
        test -z $existingcompletions[1]
        or begin
            test (count $existingcompletions) -gt 1
            and echo "$quiet""found multiple completion files, cating all" \n
            for compfile in $existingcompletions
                echo $quiet(set_color red) (string replace $HOME '~' "$compfile") (set_color normal)
                cat $compfile | fish_indent $quiet --ansi
                echo \n
            end
        end
    end

    set -l stat $status
    rm -f $tmpname >/dev/null
    return $stat
end
