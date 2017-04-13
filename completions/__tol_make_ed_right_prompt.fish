set __complete_tol_make_ed_right_prompt editor editor_color item item_color action extra
complete -xc __tol_make_ed_right_prompt -a '(set -l things $__complete_tol_make_ed_right_prompt; for i in (seq 1 (count $things)); echo -s $i. $things[$i] \t argv[$i]; end)'
