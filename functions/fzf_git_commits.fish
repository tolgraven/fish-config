function fzf_git_commits -a query
    set -l shas
    set -l sha
    set -l q "--query='$query'"

    set -l k
    git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" | fzf --ansi --multi --no-sort --reverse $q --tiebreak=index --print-query --expect=ctrl-d --toggle-sort=\` | read -l out
    set q (echo "$out" | head -1) #<<< "$out")
    set k (echo "$out" | head -2 | tail -1) #<<< "$out" | tail -1)
    set shas (echo "$out" | sed '1,2d;s/^[^a-z0-9]*//;/^$/d' | awk '{print $1}') #<<< "$out" |awk '{print $1}')
    #test -z "$shas"
    #and continue

    if [ "$k" = 'ctrl-d' ]
        git diff --color=always $shas | less -R
    else
        for sha in $shas
            git show --color=always $sha | less -R
        end
    end

end
