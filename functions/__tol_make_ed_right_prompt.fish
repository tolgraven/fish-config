function __tol_make_ed_right_prompt --description 'construct right prompt for readline eds' --argument editor editor_color item item_color
	echo "printf \"%s$editor%s editing %s$item%s \" \
  (tput smso)(set_color $editor_color) (set_color normal)   (set_color $item_color)(tput smso) (set_color normal)"
end
