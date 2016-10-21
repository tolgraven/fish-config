function fish_user_key_bindings
	bind \ec __tol_copy_pipe # add pipe to pbcopy to end of cmdline #bind \ev '__tol_paste_pipe' #add pbpaste
    bind \eC __tol_copy_line # curr line to system clipboard
    bind \eI __tol_fish_indent # adds pipe to indent/color    
    bind \cv __tol_clipboard_paste
    bind \ed __tol_dupl_line
    bind \eo __tol_down_new_line #bind \eo down-line

    bind \er repaint #force-repaint #difference?
    bind \e0 'clear; commandline -f repaint' # clear scr
    bind \ei 'commandline (commandline | fish_indent); commandline -f repaint' # indent and repaint
    bind \et 'tolmenu tolmenu_get_actions eval'
    bind \eD debug_commandline

    bind -k sr '__tol_toggle_selecting; set -q __tol_fish_selecting; or begin; commandline -f backward-char; commandline -f forward-char; end' # arrow up 
    bind -k sf swap-selection-start-stop # arrow down
    bind -k shome '__tol_toggle_selecting on; commandline -f beginning-of-line'
    bind -k send '__tol_toggle_selecting on; commandline -f end-of-line'
    bind -k sleft '__tol_toggle_selecting on; commandline -f backward-bigword'
    bind -k sright '__tol_toggle_selecting on; commandline -f forward-bigword'
    bind \ck 'set -q __tol_fish_selecting; and begin; commandline -f kill-selection; __tol_toggle_selecting off; end; or commandline -f kill-line'
    bind \ea beginning-of-buffer
    bind \ee end-of-buffer
    bind \ea\ek 'commandline -r ""; commandline -f repaint' #erase all lines in buffer
    #bind \es\ec __tol_set_anchor_pos; bind \er\ec __tol_restore_anchor_pos #bind \eQUE 'FLASH LINE-NUMs for prompt; wait for 2nr input sequence jump to specific line, fade'. +similar but for moving within line like vim-seek.
    bind \ef __tol_desc_token #basic desc only for files, F for proper cat etc
    bind \eF __tol_cat_token
    bind \eg __tol_edit_token
    bind \eG '__tol_edit_token force'

    bind \ej __tol_eval_job_and_sneak_peek
    bind \ee\et 'commandline -t (eval (commandline -t))' # eval curr token
    bind \ee\eb 'commandline (eval (commandline))' # eval curr cmdline
    bind \ee\et 'set -l cmdline (commandline); set -l cmdpos (commandline -C); commandline -f execute; commandline $cmdline; commandline -C $cmdpos' #run entire cmdline, reinsert it
    bind \ee\ev 'commandline -t (vared (commandline -t))'
    bind \em transpose-words
    bind \e- __tol_toggle_comment_commandline #needs to learn to seek to first -non whitespace 
    #idea:temp second miniprompt over old one #basically what i have with readline things 
    #MORE IDEAS: something to run/eval curr code without leaving position within it (whether fails or not), and to divert all the error msgs when they come, either to "other part of same screen" or prob easier to do with tmux/fzf or just dumping to some file taken in from another pane, slight parsing. # then instead of spewing massive error msgs about what variables or whatever it just highlights them where they are... 
    bind \e\' __tol_move_dir_up
    bind \e+ __tol_rerun_last_command

    bind \cr __tol_fzf_ctrl_r #tol version ctrl-r
    bind ! __history_previous_command ### bang-bang ### 
    bind '$' __history_previous_command_arguments
    bind \ct '__fzf_ctrl_t' ### fzf ### 
    bind \cx '__fzf_ctrl_x' # bind \cr '__fzf_ctrl_r'
end
