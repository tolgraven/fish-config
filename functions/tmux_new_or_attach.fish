function tmux_new_or_attach -a session -d "tmux new -A"
test -z "$session"
and set session "default"
tmux new -A -s $session
end
