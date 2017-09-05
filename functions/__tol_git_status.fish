function __tol_git_status --description 'print git status, for keybind'
#    git config something #force color
set -l output (git -c color.status=always status --porcelain | string replace --all ' M ' (set_color bryellow) | string replace --all '?? ' (set_color brred))
#    set (count $output) -gt 1
#    and set -l output $output[2..-2] #cut first and last line (when non-porcelain)
clear_below_cursor
tput cud1
echo -ns $output\n
tput cuu1
tput cuu (count $output)
commandline -f repaint
end
