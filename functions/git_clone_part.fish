function git_clone_part --description 'clone just part of git repo, using svn export' --argument repo dirs
test -z "$repo"
and return 1
not test -e $repo
and not string match -q -- 'http*' $repo
and set repo 'https://'$repo
for dir in $argv[2..-1]
#svn ls $repo.git/trunk/$dir
svn export $repo.git/trunk/$dir

end
end
