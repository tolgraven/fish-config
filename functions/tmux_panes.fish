function tmux_panes -d "list all tmux panes across sessions"
  for session in (tmux list-sessions -F '#{session_name}')
    tmux list-windows -t "$session" -F '#{window_index} "#{window_name}"' | while read win_index window
      tmux list-panes -t "$session:$win_index" -F"#{pane_index} #{pane_tty} #{pane_pid}" | while read pane tty pid
        printf "%-30s %30s\n" "$session:$win_index:$pane (Window $window, Pane: $pane)" $tty
        # pstree $pid
				ps -forest -g $pid
				echo
			end
			echo
		end
	end
end
