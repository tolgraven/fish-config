function tolfunc --description 'Edit function definition'
	set -l funcname
    while set -q argv[1]
        switch $argv[1]
            case -h --help
                __fish_print_help funced
                return 0
            case --
                set funcname $funcname $argv[2]
                set -e argv[2]
            case '-*'
                printf (_ "%s: Unknown option %s\n") func $argv[1]
                return 1
            case '*' '.*'
                set funcname $funcname $argv[1]
        end
        set -e argv[1]
    end
    if test (count $funcname) -ne 1
        _ "tolfunc: You must specify a function name"\n
        return 1
    end
    set -l init
    switch $funcname
        case '-*'
            set init function -- $funcname\n\nend
        case '*'
            set init function $funcname\n\nend
    end

    set -l IFS
    if functions -q -- $funcname
        set init (functions -- $funcname | fish_indent --no-indent) #must indent or breaks when around top of file.weird
    end
    set -l prompt ''
    set -l clocky (fish_right_prompt)
    set -l right_prompt 'printf "%stolfunc%s editing %s%s%s " \
  (tput smso)(set_color brblue) (set_color normal)   (set_color green)(tput smso) "$funcname" (set_color normal)' #(tput smso)(string sub --start=-6 $clocky)(set_color normal)'
    set -e IFS # HERE SHOULD HAVE SOMETHING TO INDICATE IF THESE HAS BEEN ANY CHANGE WHILE EDITING. put in right_prompt somehow hmm?
    if read --prompt $prompt --right-prompt $right_prompt -c "$init" -s cmd
        set -l IFS # Shadow IFS _again_ to avoid array splitting in command substitution
        eval (echo -n $cmd | fish_indent) # can indent manually with \eI, if needed
    end
end
