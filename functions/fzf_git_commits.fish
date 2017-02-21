function fzf_git_commits --argument query
not test -z "$query"
and set -l q "--query='$query'"

git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" | fzf --ansi --multi --no-sort --reverse $q --tiebreak=index --height=50% | read -l --array out
test -z "$out"
and return
set -l hash (string split -- ' ' $out)[2] #nope need a regexp bc theyre different places
git show --color=always $hash | fzf --reverse --no-sort --height=50% >/dev/null
#set k (echo "$out" | head -2 | tail -1) #<<< "$out" | tail -1)
#set shas (echo $out | sed '1,2d;s/^[^a-z0-9]*//;/^$/d' | awk '{print $1}')


debug "k: $k, shas: $shas"
return

if test "$k" = 'ctrl-d'
git diff --color=always $shas #| less -R
else
for sha in $shas
git show --color=always $sha #| less -R
end
end
end
