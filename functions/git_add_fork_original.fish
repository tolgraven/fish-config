function git_add_fork_original
# fix more better
not string match -q 'http*'$argv
and set -l prefix 'https://github.com/'
set -l url prefix$argv
git remote add upstream $url
end
