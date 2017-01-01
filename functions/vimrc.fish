function vimrc --description 'edit vimrc'
    pushd (pwd)
    cd ~/.vim

    itermprofileswitch 'vim -S sessions/vimrcSession.vim' vim-vimrc $argv
    popd
end
