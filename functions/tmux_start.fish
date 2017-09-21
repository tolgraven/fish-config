function tmux_start
command tmux -f ~/.config/tmux/tmux.conf -c 'tmux_load' $argv
end
