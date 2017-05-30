function shift-arrows-select_key_bindings --description 'tol set up key bindings for shift-arrows'
#bind -k sr
bind \e\[1\;2A '__tol_toggle_selecting; set -q __tol_fish_selecting; or begin; commandline -f backward-char; commandline -f forward-char; end' # arrow up 
#bind -k sf 
bind \e\[1\;2B swap-selection-start-stop # arrow down
#bind -k shome 
bind \e\[1\;2A '__tol_toggle_selecting on; commandline -f beginning-of-line'
#bind -k send
bind \e\[1\;2B '__tol_toggle_selecting on; commandline -f end-of-line'
#bind -k sleft 
bind \e\[1\;2D '__tol_toggle_selecting on; commandline -f backward-bigword'
#bind -k sright 
bind \e\[1\;2C '__tol_toggle_selecting on; commandline -f forward-bigword'
end
