function shift-arrows-select_key_bindings -d "tol set up key bindings for shift-arrows"
bind -k sr '__tol_toggle_selecting; set -q __tol_fish_selecting; or begin; commandline -f backward-char; commandline -f forward-char; end' # arrow up 
bind -k sf swap-selection-start-stop # arrow down
bind -k shome '__tol_toggle_selecting on; commandline -f beginning-of-line'
bind -k send '__tol_toggle_selecting on; commandline -f end-of-line'
bind -k sleft '__tol_toggle_selecting on; commandline -f backward-bigword'
bind -k sright '__tol_toggle_selecting on; commandline -f forward-bigword'
end
