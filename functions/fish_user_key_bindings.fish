function fish_user_key_bindings
bind \ep\eb __tol_copy_pipe # add pipe to pbcopy to end of cmdline
bind \eC __tol_copy_line # curr line as-is to system clipboard
bind \eI __tol_fish_indent # adds pipe to indent/color    
bind \cv __tol_clipboard_paste #bind \eV cliped #bind \eY killed
bind \eb\ed binded
bind \ec\ed comped
bind \ed __tol_dupl_line
bind \eD '__tol_dupl_line comment' #duplicate and comment
bind \eo __tol_down_new_line
bind \e- __tol_toggle_comment_commandline #needs get whitespace #bind \e8 __tol_insert_left_paran #bind \e9 __tol_insert_right_paran #bind \e7 backward-jump
bind \ea beginning-of-buffer
bind \ee end-of-buffer
bind \ek kill-word #kill fwd like \ck but just one word #REMINDER: meta-delete does \cw but for just A-z etc
bind \ef forward-word #nextd-or-forward-word #forward-word #not working
bind \ea\ek 'commandline_save nuke; commandline -r ""' #nuke commandline
shift-arrows-select_key_bindings
bind \ck __tol_kill_line_or_selection
bind \er repaint
bind \eR refish #bind \ei 'commandline (commandline | fish_indent); commandline -f repaint' # indent and repaint
bind \ee\ef 'tput cuu1; tput hpa $LINES; exec fish' #"commandline 'exec fish'; commandline -f execute"
bind \eh\em __tol_history_merge
bind \et 'tolmenu_fzf tolmenu_get_actions eval'
bind \et\ea __tol_tmux_attach #good 
bind \eT __tol_tmux_attach #for ssh from ios etc
bind \ed\ee 'tmux has-session -t deluge; and tmux attach -t deluge' #bind \u0135 echo #ö #bind \u0124 echo #å
bind \e: __tol_extra_prompt
bind \ei __tol_tell_iterm
bind \eq __tol_quicklook_file
bind \ef __tol_desc_token #basic desc only for files, F for proper cat etc
bind \eF __tol_cat_token
bind \eg __tol_edit_token
bind \eG '__tol_edit_token force'
bind \ee\el '__tol_eval_line fzf' #fzf #__tol_eval_line 
bind \ee\et __tol_token_eval_replace # eval curr token
bind \et\et __tol_token_var_put_contents
bind \et\ez 'commandline_restore token_var_put_contents'
bind \ee\ej __tol_job_eval_replace #bind \ee\eb 'commandline (eval (commandline))' # eval curr cmdline
bind \ee\et __tol_run_commandline #run entire, reinsert
bind \eH __tol_token_check_help #IDEA: eval curr code without leaving pos within it (inc failing) + divert all error msgs, either other part same term or prob tmux/fzf or dump to file tail in pane, then instead of error msgs about variables, just highlight
bind \e\' __tol_move_dir_up
bind \e. __tol_rerun_last_command
fzf_key_bindings
bind \cr __tol_fzf_ctrl_r
bind ! __history_previous_command ### bang-bang ### 
bind '$' __history_previous_command_arguments
bind \e\_ __fish_go-back
bind \eP 'pwd | pbcopy' #copy cwd #bind \eb\ep 'kill -TRAP %self' #breakpoint
bind \eg\ej 'autojump_fzf insert' # as in 'go(key)'-jump #convoluted binding bc M-hjkl and zm busy for vim/tmux nav...
bind \eg\eJ "autojump_insert force" #__tol_eval_job_and_sneak_peek
bind \ez 'fg ^&-; cursor reset; commandline -f repaint' #\cz in reverse 
bind \ej\eo jobs
bind \ep\es 'pscc (commandline --token); commandline -f repaint' #list running processes for token
bind \ep\em 'pio device monitor --baud 115200 $pio_local_monitor_opts'
bind \ep\eu 'pio run -t upload $pio_local_upload_opts'
bind \r tol_execute #bind \ec\es commandline_save #bind \ec\er commandline_restore
bind \n tol_execute #wraps execute, adds clear below cursor etc #bind \cj tol_execute
debug_key_bindings
tol_history_search_bindings #bind \e\e\[A tol_token-search-backward #meta-up #bind \e\[1\;4A 'echo funkeh bind' # meta-shift-up #bind \e\[1\;4B 'echo meta-shift-down' # meta-shift-down #bind \e\[1\;4D 'prevd; commandline -f repaint' #meta-shift-left #bind \e\[1\;4C 'nextd; commandline -f repaint' #meta-shift-right
bind \ef\eg 'fg ^&-; cursor reset; commandline -f repaint'
bind \ey\ep __tol_put_contents
bind \e4 __tol_token_with_last_arg
bind \e1 __tol_token_with_last_cmdline
bind \et\et transpose-words
bind \em\ev __tol_mv_edit_file_names #blanking a line will rm/trash the filein_dir #bulk file mgmnt
bind \eg\eb __tol_git_branch
bind \ey\ey __tol_yank_to_var
bind \eg\ec fzf_git_commits
bind \ev\es __tol_vimsession
bind \e\? __fish_man_page
bind \ew forward-word 
bind \ea\ej 'autojump_fzf cd'
bind \er\er ranger
end
