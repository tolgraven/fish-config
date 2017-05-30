function update -d "update fucken errthang++"
if type -q teamocil
if test "$TMUX"
teamocil update
else
# tmux -CC new -s update fish -c "teamocil update" ^&-
tmux new -s update fish -c "teamocil update" ^&-
end
else
old-update
end
set dur $CMD_DURATION
and echo -s "Update completed in " (set_color purple) (echo $dur | humanize_duration) (set_color normal)
commandline -f repaint
end
