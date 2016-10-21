function fish_user_key_bindings
	bind \ex '__tol_copy_pipe' #add pipe to pbcopy to end of cmdline #bind \ev '__tol_paste_pipe' #add pbpaste
    bind \en '__tol_fish_indent' #adds pipe to indent/color    
    bind \cv '__tol_clipboard_paste'
    bind \er force-repaint #'commandline -f repaint' #diff?
    bind \e0 'clear; commandline -f repaint' #clear scr
    bind \ei 'commandline (commandline | fish_indent); commandline -f repaint' #indent and repaint
    bind \et 'tolmenu tolmenu_get_actions eval'
    bind \cr '__tol_fzf_ctrl_r'
    bind \eo 'debug_commandline' #bind \e- '__tol_insert_debug_line'
    bind -k sr '__tol_toggle_selecting' #'begin-selection; bind -k sr end-selection'
    bind \ck 'set -q __tol_fish_selecting; and begin; commandline -f kill-selection; __tol_toggle_selecting; end; or commandline -f kill-line' # swap-selection-start-stop
    bind \ea 'beginning-of-buffer'
    bind \ee 'end-of-buffer'
    bind \ea\ek 'commandline -r ""; commandline -f repaint'
    bind \es\ec '__tol_set_anchor_pos'
    bind \er\ec '__tol_restore_anchor_pos'
    #bind \eSOMETHING 'FLASH LINE-NUMBERS then fade'

    bind \ef '__tol_desc_token' #basic desc only for files, F for proper cat etc
    bind \eF '__tol_cat_token'
    bind \eg '__tol_edit_token'
    bind \ej '__tol_eval_job_and_sneak_peek'
    bind \ee\ej 'commandline -j (eval (commandline -j))' #bind \ee\ej 'set -g __tol_saved_job (commandline -j)'
    #bind \ee\ej 'commandline -j (eval (commandline -j)); sleep 1; commandline -j $__tol_saved_job; commandline -f repaint'

    bind \ee\et 'commandline -t (eval (commandline -t))'
    bind \ee\eb 'commandline (eval (commandline))'
    bind \ee\et 'set -l cmdline (commandline); set -l cmdpos (commandline -C); commandline -f execute; commandline $cmdline; commandline -C $cmdpos'
    bind \ee\ev 'commandline -t (vared (commandline -t))'
    bind \em transpose-words #bind \e_  #bind \e\>
    bind \e- '__tol_toggle_comment_commandline' #'__fish_toggle_comment_commandline'    #dangerous lol??
    # SOMETHING that pops up menu like slmenu, or less or more fancy -like using completions and having keybindings to interact to stuff in different ways # anyways first idea just specifically for toggling debug mode real quick without rushing out of curr pos since thats per session anyways. prob also selecting boilerplate for loops etc to wrap stuff in without leaving curr prompt. 
    # other idea: a second prompt away from where you are (but still same window) so can super quick jump away and adjust something without leaving    #MORE IDEAS:  something to run/eval curr code without leaving position within it (whether fails or not), and to divert all the error msgs when they come, either to "other part of same screen" or prob easier to do with tmux/fzf or just dumping to some file taken in from another pane, slight parsing.
    # then instead of spewing massive error msgs about what variables or whatever it just highlights them where they are...    # shortcute to like "explode abbr" manually, when its not put in the beginning of a line
    bind \e\' '__tol_move_dir_up'
    bind \ed 'commandline -f beginning-of-line; commandline -f kill-line; commandline -f yank; echo -n -s \er; commandline -f yank; commandline -f repaint' #'__tol_dupl_line' #bind \e #some key, "roll away last command" in some fancy way
    bind \e+ '__tol_rerun_last_command'
    ### bang-bang ###
    #bind ! __history_previous_command
    #bind '$' __history_previous_command_arguments
    ### fzf ###
    #bind \ct '__fzf_ctrl_t' #bind \cr '__fzf_ctrl_r'
    #bind \cx '__fzf_ctrl_x'
end
