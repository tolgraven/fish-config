function __tol_kill_line_or_selection
if set -q __tol_fish_selecting
commandline -f kill-selection
__tol_toggle_selecting off
else
commandline -f kill-line
end
end
