function __tol_tmux_attach --description 'instant call completion on available tmux sessions'
commandline_save before_tmux

commandline "tmux a -t "
commandline -f complete-and-search

commandline_restore before_tmux
end
