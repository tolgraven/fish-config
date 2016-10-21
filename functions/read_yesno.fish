function read_yesno --description 'get a straight answer' --argument text right_prompt extra
	test -z "$text"
    and set text "answer"
    test -z "$right_prompt"
    and set right_prompt 'printf "%s" (tput smso)"DONT FUCK UP"(set_color normal)'
    set -l quest 'printf "%s> " (set_color brred)(echo $text)(set_color normal)'
    read --prompt $quest --right-prompt "$right_prompt" --nchars 1 ans

    and switch $ans
        case '*y' '*Y'
            debug "GOOD" $ans $stat
            return 0 #why not fucking true ugh???
        case '*'
            debug "BAD" $ans $stat
            return 1
    end
    #debug $status
    #return 1
end
