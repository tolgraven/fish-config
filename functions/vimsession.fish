function vimsession --description 'vim session'
test -S /tmp/nvimsocket$argv
and rm /tmp/nvimsocket$argv #clear any dangling bullshit
set -x NVIM_LISTEN_ADDRESS /tmp/nvimsocket$argv
vim -S ~/.vim/session/$argv -c 'so $MYVIMRC' #already in vim func wrap #wait maybe better just here tho
end
