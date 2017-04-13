function git_commit
git add --all
git commit -m "$argv" | cat
end
