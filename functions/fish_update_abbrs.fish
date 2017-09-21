function fish_update_abbrs
test (count (abbr -l)) -eq (count (command cat $tol_fish_abbr_file))
or source $tol_fish_abbr_file
end
