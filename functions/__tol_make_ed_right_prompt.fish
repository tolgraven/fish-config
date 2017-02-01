function __tol_make_ed_right_prompt --description 'construct right prompt for readline eds' --argument editor editor_color item item_color action extra
not test -z "$action"
and set action " $action "
echo "printf \"%s$editor%s $action %s$item%s%s \" \
(set_color black -b $editor_color) (set_color normal)   (set_color black -b $item_color) (set_color normal) '$extra'"
end
