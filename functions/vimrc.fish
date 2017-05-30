function vimrc --description 'edit vimrc'
#pushd ~/.vim/nvim/
#itermprofileswitch 'vim -S ~/.vim/sessions/vimrcSession.vim' vim-vimrc $argv
#popd
vim -S ~/.vim/session/vimrc $argv -c 'so $MYVIMRC'
end
