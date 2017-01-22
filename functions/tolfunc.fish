function tolfunc --description 'Edit function definition' -a function
    test -z "$funcname"
    and return 1

    if functions -q -- $funcname
        set -l IFS #to preserve linebreaks
        set init (functions -- $funcname | fish_indent --no-indent) #must run indent or breaks when around top of file.weird
        set -e IFS
    else
        set init function -- $funcname\n\nend
    end

    set -l prompt ''
    set -l right_prompt 'printf "%stolfunc%s editing %s%s%s " \
  (tput smso)(set_color brblue) (set_color normal)   (set_color green)(tput smso) "$funcname" (set_color normal)'

    if read --prompt $prompt --right-prompt $right_prompt -c "$init" --mode-name inlined -s cmd #HERE SHOULD HAVE SOMETHING TO INDICATE IF THESE HAS BEEN ANY CHANGE WHILE EDITING. put in right_prompt somehow hmm?
        #set -l IFS    #no need since just passing it on to func using echo
        echo -ns $cmd\n | fish_indent
    end
end
