function __tol_tmux_attach --description 'instant call completion on available tmux sessions'
commandline_save before_tmux
#sleep 0.1

commandline "tmux a -t "
commandline -f repaint
#sleep 0.1
#commandline -f complete-and-search
commandline -f complete
commandline -f complete-and-search
#commandline -f execute

#sleep 0.5
#commandline_restore before_tmux
end
