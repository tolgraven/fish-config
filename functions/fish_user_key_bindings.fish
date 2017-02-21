function fish_user_key_bindings
bind \ep\eb __tol_copy_pipe # add pipe to pbcopy to end of cmdline
bind \eC __tol_copy_line # curr line as-is to system clipboard
bind \eI __tol_fish_indent # adds pipe to indent/color    
bind \cv __tol_clipboard_paste
bind \eV 'cliped; commandline -f repaint'
bind \eY 'killed; commandline -f repaint'
bind \eb\ed "binded; commandline -f repaint"
bind \ec\ed "comped (commandline --token); commandline -f repaint"
bind \ed __tol_dupl_line
bind \eD '__tol_dupl_line; __tol_toggle_comment_commandline; commandline -f down-line' #duplicate and comment
bind \eo __tol_down_new_line
bind \e- __tol_toggle_comment_commandline #needs to learn whitespace  #bind \e8 __tol_insert_left_paran #bind \e9 __tol_insert_right_paran
bind \e7 backward-jump
bind \ea beginning-of-buffer
bind \ee end-of-buffer
bind \ek kill-word #REMINDER: meta-delete is \cw but for just a-z 0-9
bind \ef forward-word
bind \ea\ek 'commandline -r ""; commandline -f repaint' #erase all lines in buffer
shift-arrows-select_key_bindings
bind \ck 'if set -q __tol_fish_selecting; commandline -f kill-selection; __tol_toggle_selecting off; else; commandline -f kill-line; end'

bind \er repaint #force-repaint #difference?
bind \eR refish #bind \ei 'commandline (commandline | fish_indent); commandline -f repaint' # indent and repaint
bind \ee\ef "commandline 'exec fish'; commandline -f execute"
bind \eh\em 'history merge; echo -n (set_color brblue)"History merged!"; sleep 0.4; commandline -f repaint'

bind \et 'tolmenu_fzf tolmenu_get_actions eval' #'tolmenu tolmenu_get_actions eval'
bind \e: __tol_extra_prompt
bind \ei __tol_tell_iterm
bind \eq __tol_quicklook_file #bind \eM 'set -g __tol_mark_pos (commandline --cursor)' #bind \en 'set -q __tol_mark_pos; and commandline --cursor $__tol_mark_pos'
bind \ef __tol_desc_token #basic desc only for files, F for proper cat etc
bind \eF __tol_cat_token
bind \eg __tol_edit_token
bind \eG '__tol_edit_token force'

bind \ee\el '__tol_eval_line fzf' #fzf #__tol_eval_line 
bind \ee\et 'commandline -t (eval (commandline -t))' # eval curr token
bind \ee\ej 'commandline --current-job (eval (commandline --current-job)' #bind \ee\eb 'commandline (eval (commandline))' # eval curr cmdline
bind \ee\et 'set -l cmdline (commandline); set -l cmdpos (commandline -C); commandline $cmdline; commandline -C $cmdpos' #run entire, reinsert
bind \eH 'eval (commandline --token) --help; commandline -f repaint' #IDEA: eval curr code without leaving pos within it (inc failing) + divert all error msgs, either other part same term or prob tmux/fzf or dump to file tail in pane, then instead of error msgs about variables, just highlight

bind \e\' __tol_move_dir_up
bind \e. __tol_rerun_last_command

fzf_key_bindings
bind \cr __tol_fzf_ctrl_r #tol version ctrl-r
bind ! __history_previous_command ### bang-bang ### 
bind '$' __history_previous_command_arguments
bind \e\_ __fish_go-back
bind \eP 'pwd | pbcopy' #copy cwd
bind \eb\ep 'kill -TRAP %self' #breakpoint
bind \ej autojump_insert
bind \eJ "autojump_insert force" #__tol_eval_job_and_sneak_peek
bind \ez 'fg ^&-; cursor reset; commandline -f repaint' #\cz in reverse 
bind \ej\eo jobs
bind \ep\es 'pscc (commandline --token); commandline -f repaint' #list running processes for token
bind \ep\em 'pio device monitor --baud 115200 $pio_local_monitor_opts'
bind \ep\eu 'pio run -t upload $pio_local_upload_opts'

bind \r tol_execute #bind \ec\es commandline_save #bind \ec\er commandline_restore
debug_key_bindings
bind -k up 'tol_up-or-search 7'
bind -k down 'tol_down-or-search 7'
bind \cP 'tol_up-or-search 7'
bind \e\[A 'tol_up-or-search 7'
bind \e\[B 'tol_down-or-search 7'
bind \cN 'tol_down-or-search 7'
bind \e+ history-token-search-backward
bind \e, history-search-backward
bind \e\; history-search-forward
bind \eJ history-search-forward
bind \eK history-search-backward
#bind \e\e\[A tol_token-search-backward #meta-up #bind \e\[1\;4A 'echo funkeh bind' # meta-shift-up #bind \e\[1\;4B 'echo meta-shift-down' # meta-shift-down #bind \e\[1\;4D 'prevd; commandline -f repaint' #meta-shift-left #bind \e\[1\;4C 'nextd; commandline -f repaint' #meta-shift-right
bind \ef\eg fzf_git_commits #bind \et\ea __tol_tmux_attach
bind \ey\ep __tol_put_contents
bind \e4 __tol_token_with_last_arg
bind \e1 __tol_token_with_last_cmdline
#bind - __tol_autocomplete
end
