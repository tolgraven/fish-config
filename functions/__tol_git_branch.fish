function __tol_git_branch
git branch -v | fzf --height=10 --reverse | read -l choice
test -z "$choice"
or git checkout (string replace '*' '' $choice | string trim | string split ' ')[1]
end
