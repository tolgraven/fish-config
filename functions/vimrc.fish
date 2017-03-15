function vimrc --description 'edit vimrc'
pushd ~/.vim/nvim/

itermprofileswitch 'vim -S ~/.vim/sessions/vimrcSession.vim' vim-vimrc $argv
popd
end
