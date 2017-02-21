function jq_repl --argument data
#test -z "$data"
#and while read -l line #fucks up read rest of function??? so cant pipe? ugh
#set data $data $line
#end

#tput smcup
set -l prompt 'printf "jq > "'
set -l rightprompt (__tol_make_ed_right_prompt "jq" blue "json" brred)
set -l init ''
while true
read --prompt "$prompt" --right-prompt "$rightprompt" --command "$cmd" cmd

#clear
echo $data | jq "$cmd"
#echo $data | jq 'map(.options[])[].option'
#end
end
end
