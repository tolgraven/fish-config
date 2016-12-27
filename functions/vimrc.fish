function vimrc --description 'edit vimrc'
	pushd (pwd)
    cd ~/.vim

    vim -S sessions/vimrcSession.vim
    popd
end
