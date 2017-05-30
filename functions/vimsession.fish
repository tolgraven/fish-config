function vimsession --description 'vim session'
vim -S ~/.vim/session/$argv -c 'so $MYVIMRC' #already in vim func wrap #wait maybe better just here tho
end
