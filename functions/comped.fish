function comped --description 'Edit completions inline, based on funced'
	set -l completename
    while set -q argv[1]
        switch $argv[1]
            case -h --help
                echo "edit completions and stuff"
                return 0
            case -u --in-user-folder
                set completename $completename $argv[2] #yeah needs to be better
                set -e argv[2]
            case -n #echo "todo: prefill n empty completions"
            case -a #echo "todo: edit just -a bit(s) all indented and shit and then put back within quotes..."
            case --
                set completename $completename $argv[2]
                set -e argv[2]
            case '-*'
                printf (_ "%s: Unknown option %s\n") completed $argv[1]
                return 1
            case '*' '.*'
                set completename $completename $argv[1]
        end
        set -e argv[1]
    end
    test (count $completename) -ne 1
    and echo "completed: You must specify something to complete"
    and return 1 #bail

    set init
    set existingcompletions
    for i in (seq 1 (count $fish_complete_path))
        test -e $fish_complete_path[$i]/$completename.fish
        and varadd existingcompletions $fish_complete_path[$i]/$completename.fish
    end
    set -l IFS # Shadow IFS here to avoid array splitting in command substitution
    if type -q $completename
        test -z "$existingcompletions[1]"
        and set init "complete -c $completename"
        or begin
            set init (command cat $existingcompletions[1] | fish_indent) # --no-indent) #messes up functions if no indent..
            test (count $existingcompletions) -gt 1
            and echo "found multiple comp-files, editing first one in fish_complete_path (should be user completion dir in home
or youre probably fucking up as we speak), but saves to user dir, wont overwrite"
        end
    end #toled_bind_mode #introducing meh keybindings here too #need to wait bc stupid echo thing. fix better way sometime
    set -l prompt "printf '%s%s>\n ' (set_color brgreen) $existingcompletions[1]"
    set -l right_prompt 'printf "%scomped%s editing %s%s%s"    (set_color yellow)(tput smso) (set_color normal)  \
(set_color brgreen)(tput smso) '$completename' (set_color normal)'

    set -e IFS # Unshadow IFS since the fish_title breaks otherwise   #set -l result #while not set -q comped_exit
    if read --prompt "$prompt" --right-prompt "$right_prompt" --command "$init" --shell --mode-name "comped" result
        set -l IFS # Shadow IFS _again_ to avoid array splitting in command substitution
        eval (echo -n $result | fish_indent)
        or echo \n (set_color red) "UR SHIT\'s NOT PARSING!!!" \n (tput smso) "COMPLETION MAY BE BORKEN" (tput rmso)

    end #end; tol_reload_key_bindings 

    if test "$init" = "$result"
        echo "No changes detected. Exiting."
        return 0
    end
    set configdir ~/.config/fish
    set -q XDG_CONFIG_HOME
    and set configdir "$XDG_CONFIG_HOME/fish"
    if test (count $existingcompletions) -ge 1 -a -e $existingcompletions[1]
        #and test -e $existingcompletions[1]

        set maincomp $existingcompletions[1]
        if string match -q "*$XDG_CONFIG_HOME*" "$maincomp" #if in home dir
            echo "backing up completion file to" (set_color brred)(string replace "$HOME" '~' (dirname $maincomp))/(set_color brpurple)comped_backups/(set_color green).(string replace ".fish" ".bak_fish" (basename $maincomp)) (set_color normal) "because this shit is prob buggy as fuck"
            cp "$maincomp" (dirname $maincomp)/comped_backups/(string replace ".fish" ".bak_fish" (basename $maincomp))
            and echo -ns $result\n >$maincomp
        else
            echo "Creating parallel completion at $configdir/completions. Yours should take precedence"
            #cp $maincomp $configdir/completions/
            echo -ns $result\n >$configdir/completions/$completename.fish
        end
    else
        echo "You compd a comp! Or edited an existing and something went kaputt. but don't worry, nice chill trendy cat>> was used instead of evilbad cat>.
Completion written to " (set_color green) $configdir/completions/$completename.fish (set_color normal)
        echo -ns $result\n >>$configdir/completions/$completename.fish
    end
end
